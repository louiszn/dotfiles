#!/usr/bin/env bash

layout="$MODULE_DIR/layout.js"

if [[ ! -f "$layout" ]]; then
	printf "Panel layout not found: %s\n" "$layout" >&2
	exit 1
fi

if ! command -v dbus-send >/dev/null; then
	printf "dbus-send is required\n" >&2
	exit 1
fi

dbus-send \
	--session \
	--type=method_call \
	--dest=org.kde.plasmashell \
	/PlasmaShell \
	org.kde.PlasmaShell.evaluateScript \
	string:"$(cat "$layout")"

printf "Installed Plasma panel layout\n"
