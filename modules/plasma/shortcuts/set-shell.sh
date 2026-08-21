#!/usr/bin/env bash

import_lib kwin_shortcuts

bind "plasmashell" "activate application launcher" "Meta"

for entry in {1..10}; do
	key=$((entry % 10))
	bind "plasmashell" "activate task manager entry $key" "Alt+$key"
done
