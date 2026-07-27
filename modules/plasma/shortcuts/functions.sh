#!/usr/bin/env bash

bind() {
	local component="$1"
	local action="$2"
	shift 2

	if (( $# == 0 )); then
		printf "bind: no shortcut supplied for %s/%s\n" "$component" "$action" >&2
		return 1
	fi

	local shortcuts
	printf -v shortcuts "%s\t" "$@"
	shortcuts="${shortcuts%$'\t'}"

	kwriteconfig6 \
		--file kglobalshortcutsrc \
		--group "$component" \
		--key "$action" \
		"${shortcuts},none,${action}"
}

unbind() {
	local component="$1"
	local action="$2"

	kwriteconfig6 \
		--file kglobalshortcutsrc \
		--group "$component" \
		--key "$action" \
		"none,none,${action}"
}

bind_app() {
	local desktop_id="$1"
	shift

	if (( $# == 0 )); then
		printf "bind_app: no shortcut supplied for %s\n" "$desktop_id" >&2
		return 1
	fi

	local shortcuts
	printf -v shortcuts "%s\t" "$@"
	shortcuts="${shortcuts%$'\t'}"

	kwriteconfig6 \
		--file kglobalshortcutsrc \
		--group services \
		--group "$desktop_id" \
		--key _launch \
		"$shortcuts"
}

unbind_app() {
	local desktop_id="$1"

	kwriteconfig6 \
		--file kglobalshortcutsrc \
		--group services \
		--group "$desktop_id" \
		--key _launch \
		"none"
}
