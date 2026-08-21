#!/usr/bin/env bash

import_lib packages

install_packages zsh

printf "Installing .zshrc...\n"

install \
	-m 0644 \
	"$MODULE_DIR/.zshrc" \
	"$HOME/.zshrc"

zsh_path="$(command -v zsh)"

if [[ "${SHELL:-}" != "$zsh_path" ]]; then
	printf "Setting Zsh as default shell...\n"
	chsh -s "$zsh_path"
fi
