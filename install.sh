#!/usr/bin/env bash

set -euo pipefail

root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
blue="#3DAEE9"

readonly zsh_label="Zsh (For XBPS + sbctl only)"
readonly krohnkite_label="Krohnkite — Tiling WM"
readonly geometry_label="Geometry Change — KWin effect"
readonly panel_label="Plasma panel"
readonly shortcuts_label="Keyboard shortcuts"

readonly clear_shortcuts_label="Clear existing shortcuts"
readonly wm_shortcuts_label="Window manager shortcuts"
readonly shell_shortcuts_label="Plasma Shell shortcuts"
readonly app_shortcuts_label="Application shortcuts"

if ! command -v gum >/dev/null; then
	printf "gum is required to run the installer\n" >&2
	exit 1
fi

choose_many() {
	local header="$1"
	local height="$2"
	shift 2

	gum choose \
		--no-limit \
		--height "$height" \
		--header "$header" \
		--header.foreground "$blue" \
		--cursor.foreground "$blue" \
		--selected.foreground "$blue" \
		"$@"
}

is_selected() {
	local needle="$1"
	local selection="$2"

	grep -Fxq -- "$needle" <<< "$selection"
}

add_to_plan() {
	plan_names+=("$1")
	plan_scripts+=("$root/$2")
}

run_plan() {
	local index
	local script

	for index in "${!plan_scripts[@]}"; do
		script="${plan_scripts[$index]}"

		if [[ ! -f "$script" ]]; then
			printf "Installer not found: %s\n" "$script" >&2
			exit 1
		fi

		printf "\n==> %s\n" "${plan_names[$index]}"
		bash "$script"
	done
}

main_options=(
	"$zsh_label"
	"$krohnkite_label"
	"$geometry_label"
	"$panel_label"
	"$shortcuts_label"
)

if ! main_selection="$(
	choose_many \
		"Select components to install" \
		10 \
		"${main_options[@]}"
)"; then
	printf "Installation cancelled.\n"
	exit 0
fi

if [[ -z "$main_selection" ]]; then
	printf "Nothing selected.\n"
	exit 0
fi

shortcut_selection=""

if is_selected "$shortcuts_label" "$main_selection"; then
	shortcut_options=(
		"$clear_shortcuts_label"
		"$wm_shortcuts_label"
		"$shell_shortcuts_label"
		"$app_shortcuts_label"
	)

	if ! shortcut_selection="$(
		choose_many \
			"Select keyboard shortcuts to install" \
			9 \
			"${shortcut_options[@]}"
	)"; then
		printf "Installation cancelled.\n"
		exit 0
	fi
fi

plan_names=()
plan_scripts=()

if is_selected "$zsh_label" "$main_selection"; then
	add_to_plan \
		"Installing Zsh configuration" \
		"modules/zsh/install.sh"
fi

if is_selected "$krohnkite_label" "$main_selection"; then
	add_to_plan \
		"Installing Krohnkite" \
		"modules/plasma/kwin/krohnkite/install.sh"
fi

if is_selected "$geometry_label" "$main_selection"; then
	add_to_plan \
		"Installing Geometry Change effect" \
		"modules/plasma/kwin/geometry-change/install.sh"
fi

if is_selected "$clear_shortcuts_label" "$shortcut_selection"; then
	add_to_plan \
		"Clearing existing shortcuts" \
		"modules/plasma/shortcuts/clear.sh"
fi

if is_selected "$wm_shortcuts_label" "$shortcut_selection"; then
	add_to_plan \
		"Installing window manager shortcuts" \
		"modules/plasma/shortcuts/set-wm.sh"
fi

if is_selected "$shell_shortcuts_label" "$shortcut_selection"; then
	add_to_plan \
		"Installing Plasma Shell shortcuts" \
		"modules/plasma/shortcuts/set-shell.sh"
fi

if is_selected "$app_shortcuts_label" "$shortcut_selection"; then
	add_to_plan \
		"Installing application shortcuts" \
		"modules/plasma/shortcuts/set-apps.sh"
fi

if is_selected "$panel_label" "$main_selection"; then
	add_to_plan \
		"Installing Plasma panel" \
		"modules/plasma/panel/install.sh"
fi

if (( ${#plan_scripts[@]} == 0 )); then
	printf "Nothing selected for installation.\n"
	exit 0
fi

printf "\nSelected components:\n%s\n" "$main_selection"

if [[ -n "$shortcut_selection" ]]; then
	printf "\nSelected shortcuts:\n%s\n" "$shortcut_selection"
fi

printf "\n"

if ! gum confirm \
	--prompt.foreground "$blue" \
	--selected.background "$blue" \
	--selected.foreground "#000000" \
	"Continue with installation?"; then
	printf "Installation cancelled.\n"
	exit 0
fi

run_plan

printf "\n"

gum style \
	--bold \
	--foreground "$blue" \
	"Installation completed."