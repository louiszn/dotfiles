#!/usr/bin/env bash

id="kwin4_effect_geometry_change"
package="$MODULE_DIR/geometry-change.zip"
installed="${XDG_DATA_HOME:-$HOME/.local/share}/kwin/effects/$id"

if [[ ! -f "$package" ]]; then
	printf "Package not found: %s\n" "$package" >&2
	exit 1
fi

if ! command_exists kpackagetool6; then
	printf "kpackagetool6 is required\n" >&2
	exit 1
fi

if [[ -d "$installed" ]]; then
	kpackagetool6 \
		--type KWin/Effect \
		--upgrade "$package"
else
	kpackagetool6 \
		--type KWin/Effect \
		--install "$package"
fi

kwriteconfig6 \
	--file kwinrc \
	--group Plugins \
	--key "${id}Enabled" \
	true

kwriteconfig6 \
	--file kwinrc \
	--group "Effect-$id" \
	--key Duration \
	500

printf "Installed and configured %s\n" "$id"
