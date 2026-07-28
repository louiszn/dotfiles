#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$0")/functions.sh"

bind "plasmashell" "activate application launcher" "Meta"

for entry in {1..10}; do
	key=$((entry % 10))
	bind "plasmashell" "activate task manager entry $key" "Alt+$key"
done
