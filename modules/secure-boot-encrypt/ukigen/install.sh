#!/bin/bash

import_lib packages

install_packages systemd-boot-efistub

sudo install \
	-m 0755 \
	"$MODULE_DIR/ukigen" \
	/usr/local/bin/ukigen
