#!/usr/bin/env bash

import_lib packages

if ! package_exists sbctl; then
	printf "sbctl is not installed.\n" >&2
	exit 1
fi

sudo install \
	-m 0755 \
	"$MODULE_DIR/sbctl-batch-sign" \
	/usr/local/bin/sbctl-batch-sign
