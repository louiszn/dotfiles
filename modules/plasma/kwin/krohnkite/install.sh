#!/usr/bin/env bash

package="$MODULE_DIR/krohnkite.kwinscript"
config="$MODULE_DIR/config.sh"
installed="${XDG_DATA_HOME:-$HOME/.local/share}/kwin/scripts/krohnkite"

if [[ ! -f "$package" ]]; then
	printf "Krohnkite package not found: %s\n" "$package" >&2
	exit 1
fi

if ! command_exists kpackagetool6; then
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
	--group Windows \
	--key ElectricBorderTiling \
	false


if [[ -f "$config" ]]; then
	printf "Applying Krohnkite configuration...\n"
	bash "$config"
fi
