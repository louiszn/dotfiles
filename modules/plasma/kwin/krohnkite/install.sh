#!/usr/bin/env bash

set -euo pipefail

directory="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
package="$directory/krohnkite.kwinscript"
installed="${XDG_DATA_HOME:-$HOME/.local/share}/kwin/scripts/krohnkite"

if [[ ! -f "$package" ]]; then
	printf "Krohnkite package not found: %s\n" "$package" >&2
	exit 1
fi

if ! command -v kpackagetool6 >/dev/null; then
	printf "kpackagetool6 is required\n" >&2
	exit 1
fi

if [[ -d "$installed" ]]; then
	printf "Updating Krohnkite...\n"
	kpackagetool6 \
		--type KWin/Script \
		--upgrade "$package"
else
	printf "Installing Krohnkite...\n"
	kpackagetool6 \
		--type KWin/Script \
		--install "$package"
fi

kwriteconfig6 \
	--file kwinrc \
	--group Plugins \
	--key krohnkiteEnabled \
	true

kwriteconfig6 \
	--file kwinrc \
	--group Plugins \
	--key krohnkiteEnabled \
	true

kwriteconfig6 \
	--file kwinrc \
	--group Windows \
	--key ElectricBorderTiling \
	false

printf "%s\n" \
	"Krohnkite installed and enabled." \
	"Log out and back in to activate it."
