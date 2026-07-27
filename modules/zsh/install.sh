#!/usr/bin/env bash

set -euo pipefail

directory="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
config="$directory/config"
scripts="$directory/scripts"
bin="${XDG_BIN_HOME:-$HOME/.local/bin}"

if ! command -v zsh >/dev/null; then
	if ! command -v xbps-install >/dev/null; then
		printf "zsh is not installed and xbps-install is unavailable\n" >&2
		exit 1
	fi

	printf "Installing Zsh...\n"
	sudo xbps-install -y zsh
fi

if [[ -d "$config" ]]; then
	printf "Installing Zsh configuration...\n"
	cp -a "$config/." "$HOME/"
fi

if [[ -d "$scripts" ]]; then
	printf "Installing user scripts...\n"
	install -d "$bin"

	for script in "$scripts"/*; do
		[[ -f "$script" ]] || continue

		install \
			-m 0755 \
			"$script" \
			"$bin/$(basename "$script")"
	done
fi

zsh_path="$(command -v zsh)"

if [[ "${SHELL:-}" != "$zsh_path" ]]; then
	printf "Setting Zsh as the default shell...\n"

	if command -v chsh >/dev/null; then
		chsh -s "$zsh_path"
	else
		printf "chsh is unavailable; set your shell manually:\n" >&2
		printf "  chsh -s %s\n" "$zsh_path" >&2
	fi
fi

if [[ ":${PATH:-}:" != *":$bin:"* ]]; then
	printf "Warning: %s is not currently in PATH\n" "$bin" >&2
fi

printf "Installed Zsh configuration and scripts.\n"
