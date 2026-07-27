#!/usr/bin/env bash

set -euo pipefail

set_config() {
	kwriteconfig6 \
		--file kwinrc \
		--group Script-krohnkite \
		--key "$1" \
		"$2"
}

set_config floatingClass systemsettings
set_config monocleMaximize false
set_config screenGapBetween 5
set_config screenGapBottom 8
set_config screenGapLeft 8
set_config screenGapRight 8
set_config screenGapTop 8
