#!/usr/bin/env bash

set -euo pipefail

directory="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

if ! command -v sbctl >/dev/null; then
	printf "sbctl is not installed.\n" >&2
	exit 1
fi

printf "Installing sbctl-batch-sign...\n"

sudo install \
	-m 0755 \
	"$directory/sbctl-batch-sign" \
	/usr/local/bin/sbctl-batch-sign

printf "sbctl helper installed.\n"
