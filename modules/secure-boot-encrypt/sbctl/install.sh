#!/usr/bin/env bash

import_lib packages

install_packages sbctl

sudo install \
	-m 0755 \
	"$MODULE_DIR/sbctl-batch-sign" \
	/usr/local/bin/sbctl-batch-sign
