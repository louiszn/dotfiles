#!/usr/bin/env bash

set -euo pipefail

if ! command -v xbps-install >/dev/null; then
	printf "xbps-install is unavailable.\n" >&2
	exit 1
fi

printf "Installing Zsh plugins...\n"

sudo xbps-install -y \
	zsh-autosuggestions \
	zsh-history-substring-search \
	zsh-syntax-highlighting

printf "Zsh plugins installed.\n"
