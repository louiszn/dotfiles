#!/usr/bin/env bash

set -euo pipefail

directory="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

if ! command -v xbps-install >/dev/null; then
	printf "xbps-install is unavailable.\n" >&2
	exit 1
fi

printf "Installing xbps-sync...\n"

sudo install \
	-m 0755 \
	"$directory/xbps-sync" \
	/usr/local/bin/xbps-sync

printf "xbps-sync installed.\n"
