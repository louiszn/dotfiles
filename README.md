# Louis Dotfiles

Personal dotfiles and system configuration, managed through an interactive installer.

## Requirements

- Python 3.11+
- [uv](https://github.com/astral-sh/uv)

## Install

```bash
git clone https://codeberg.org/louiszn/dotfiles.git
cd dotfiles

uv sync
uv run python -m installer
```

The installer will open an interactive checklist where you can select which components to install. After confirming the installation plan, it will execute the corresponding scripts defined in `installer/config.yaml`.

## Structure

```
.
├── installer/          # Interactive installer
│   ├── __main__.py     # Installer entry point
│   └── config.yaml     # Module registry
│
├── modules/            # Installation modules
│   ├── plasma/
│   └── zsh/
│
├── pyproject.toml      # Python project metadata and dependencies
└── uv.lock             # Locked Python dependencies
```

Each module is self-contained and owns its installation logic. The Python installer only handles selection, ordering, and execution.

## Development

Create or update the environment:

```bash
uv sync
```

Run the installer:

```bash
uv run python -m installer
```

Add a new Python dependency:

```bash
uv add <package>
```

Update dependencies:

```bash
uv lock --upgrade
```

## License

See [LICENSE](LICENSE).
