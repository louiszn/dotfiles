#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$0")/functions.sh"

bind "kwin" "Window Close" "Meta+Shift+Q" "Alt+F4"
bind "kwin" "Window Operations Menu" "Alt+F3"
bind "kwin" "Kill Window" "Meta+Ctrl+Esc"

bind "kwin" "Window Fullscreen" "Meta+Shift+F"
bind "kwin" "Window Maximize" "Meta+M" "Meta+PgUp"
bind "kwin" "Window Minimize" "Meta+N" "Meta+PgDown"

bind "kwin" "Overview" "Meta+W"
bind "kwin" "Grid View" "Meta+Shift+W"

bind "kwin" "KrohnkiteFocusLeft" "Meta+H" "Meta+Left"
bind "kwin" "KrohnkiteFocusRight" "Meta+L" "Meta+Right"
bind "kwin" "KrohnkiteFocusDown" "Meta+J" "Meta+Down"
bind "kwin" "KrohnkiteFocusUp" "Meta+K" "Meta+Up"

bind "kwin" "KrohnkiteShiftLeft" "Meta+Shift+H"
bind "kwin" "KrohnkiteShiftRight" "Meta+Shift+L"
bind "kwin" "KrohnkiteShiftDown" "Meta+Shift+J"
bind "kwin" "KrohnkiteShiftUp" "Meta+Shift+K"

bind "kwin" "KrohnkiteShrinkWidth" "Meta+Ctrl+H"
bind "kwin" "KrohnkiteGrowWidth" "Meta+Ctrl+L"
bind "kwin" "KrohnkiteGrowHeight" "Meta+Ctrl+J"
bind "kwin" "KrohnkiteShrinkHeight" "Meta+Ctrl+K"

bind "kwin" "KrohnkiteToggleFloat" "Meta+F"
bind "kwin" "KrohnkiteSetMaster" "Meta+Return"
bind "kwin" "KrohnkiteNextLayout" 'Meta+\'
bind "kwin" "KrohnkitePreviousLayout" 'Meta+|' 'Meta+Shift+\'

bind "kwin" "Overview" "Meta+W"
bind "kwin" "Walk Through Windows" "Alt+Tab"
bind "kwin" "Walk Through Windows (Reverse)" "Alt+Shift+Tab"

bind "kwin" "view_zoom_in" "Meta++" "Meta+="
bind "kwin" "view_zoom_out" "Meta+-"
bind "kwin" "view_actual_size" "Meta+Ctrl+0"

shifted_keys=(')' '!' '@' '#' '$' '%' '^' '&' '*' '(')

for workspace in {1..10}; do
	key=$((workspace % 10))
	shifted_key="${shifted_keys[$key]}"

	bind "kwin" "Switch to Desktop $workspace" "Meta+$key"
	bind "kwin" "Window to Desktop $workspace" "Meta+Shift+$key" "Meta+$shifted_key"
done
