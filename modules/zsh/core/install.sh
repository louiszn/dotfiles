#!/usr/bin/env bash

set -euo pipefail

directory="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

printf "Installing Zsh...\n"

sudo xbps-install -y zsh

printf "Installing .zshrc...\n"

install \
	-m 0644 \
	"$directory/.zshrc" \
	"$HOME/.zshrc"

zsh_path="$(command -v zsh)"

if [[ "${SHELL:-}" != "$zsh_path" ]]; then
	printf "Setting Zsh as default shell...\n"
	chsh -s "$zsh_path"
fi

printf "Zsh core installed.\n"
