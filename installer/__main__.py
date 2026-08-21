from __future__ import annotations

import os
import subprocess
import sys
from pathlib import Path

import yaml
from pydantic import BaseModel, model_validator
from questionary import Choice, Style, checkbox, confirm
from rich.console import Console


class Module(BaseModel):
    title: str
    default: bool = False
    script: Path | None = None
    modules: list[Module] | None = None

    @model_validator(mode="after")
    def _check_leaf_or_branch(self) -> Module:
        has_script = self.script is not None
        has_children = self.modules is not None
        if has_script == has_children:
            raise ValueError(
                f"Module '{self.title}' must have either 'script' (leaf) "
                f"or 'modules' (branch), not both/neither."
            )
        return self


Module.model_rebuild()


class Group(BaseModel):
    title: str
    modules: list[Module]


class Config(BaseModel):
    title: str
    groups: list[Group]


STYLE = Style(
    [
        ("qmark", ""),
        ("question", "bold"),
        ("answer", ""),
        ("pointer", "fg:#3DAEE9 bold"),
        ("highlighted", "fg:#7DD3FC noreverse"),
        ("selected", "fg:#2678A8 noreverse"),
        ("checkbox", "fg:#3DAEE9"),
        ("checkbox-selected", "fg:#2678A8 noreverse"),
    ]
)

ROOT = Path(__file__).resolve().parent.parent
CONFIG_PATH = ROOT / "installer" / "config.yaml"

console = Console()


def load_config() -> Config:
    """Load and validate the installer config from YAML."""
    with CONFIG_PATH.open("r", encoding="utf-8") as file:
        return Config.model_validate(yaml.safe_load(file))


def choose_from_modules(title: str, modules: list[Module]) -> list[Module]:
    """
    Prompt for a list of modules at one level.

    Both leaf and branch modules appear as checkbox items in the same
    prompt. If a selected item is a branch, its children are prompted
    next (recursively) instead of being installed directly.
    """
    selected: list[Module] = []

    result = checkbox(
        title,
        choices=[
            Choice(title=module.title, value=module, checked=module.default)
            for module in modules
        ],
        style=STYLE,
    ).ask()

    if result is None:
        raise SystemExit(0)

    for module in result:
        if module.modules is not None:
            selected.extend(choose_from_modules(module.title, module.modules))
        else:
            selected.append(module)

    return selected


def choose_modules(config: Config) -> list[Module]:
    """Prompt the user to pick modules, group by group."""
    selected: list[Module] = []

    for group in config.groups:
        selected.extend(choose_from_modules(group.title, group.modules))

    return selected


def confirm_installation(modules: list[Module]) -> bool:
    """Show the installation plan and ask for confirmation."""
    console.print("[bold]Installation plan[/]")

    for module in modules:
        console.print(f"[cyan]✓[/] {module.title}")

    return bool(confirm("Continue?", default=True, style=STYLE).ask())


def run(modules: list[Module]) -> None:
    """Run each module's install script in order."""
    total = len(modules)

    for index, module in enumerate(modules, start=1):
        console.print(f"[bold cyan][{index:02}/{total:02}] {module.title}[/]")

        script = module.script
        assert script is not None  # only leaf modules ever reach here

        script_path = ROOT / script
        if not script_path.exists():
            console.print(f"[red]✗ Script not found: {script_path}[/]")
            raise SystemExit(1)

        try:
            env = {
                **os.environ,
                "ROOT": str(ROOT),
                "BASH_ENV": str(ROOT / "modules/lib/common.sh"),
                "MODULE_DIR": str(script_path.parent)
            }

            process = subprocess.run(
                ["bash", str(script_path)],
                cwd=ROOT,
                env=env,
                check=False,
            )

            returncode = process.returncode

            if returncode == 0:
                console.print("[green]done: Applied successfully")
            else:
                console.print(f"[red]error: failed with code {returncode}.[/]")
                raise SystemExit(returncode)
        except OSError as exc:
            console.print(f"[red]✗ Failed to start {module.title}: {exc}[/]")
            raise SystemExit(1) from exc


def main() -> None:
    config = load_config()
    console.print(f"[bold cyan]{config.title}[/]")

    modules = choose_modules(config)

    if not modules:
        console.print("[yellow]Nothing selected.[/]")
        return

    if not confirm_installation(modules):
        console.print("[yellow]Installation cancelled.[/]")
        return

    run(modules)

    console.print()
    console.print("[bold cyan]✓ Installation completed.[/]")


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        console.print("\n[yellow]Interrupted.[/]")
        sys.exit(130)
