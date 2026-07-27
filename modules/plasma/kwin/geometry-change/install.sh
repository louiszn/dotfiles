#!/usr/bin/env bash

set -euo pipefail

directory="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
package="$directory/geometry-change.zip"

id="kwin4_effect_geometry_change"
installed="${XDG_DATA_HOME:-$HOME/.local/share}/kwin/effects/$id"

if [[ ! -f "$package" ]]; then
	printf "Package not found: %s\n" "$package" >&2
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
