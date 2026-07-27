#!/usr/bin/env bash

set -euo pipefail

config="${XDG_CONFIG_HOME:-$HOME/.config}/kglobalshortcutsrc"
backup_dir="${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles/shortcuts"
timestamp="$(date +%Y%m%d-%H%M%S)"
backup="$backup_dir/kglobalshortcutsrc.$timestamp.bak"
temporary="$(mktemp "${config}.XXXXXX")"

mkdir -p "$backup_dir"

if [[ ! -f "$config" ]]; then
	printf "Shortcut config not found: %s\n" "$config" >&2
	exit 1
fi

cp -a "$config" "$backup"

awk '
	/^[[:space:]]*\[/ {
		print
		next
	}

	/^[[:space:]]*(_k_friendly_name|#|;|$)/ {
		print
		next
	}

	index($0, "=") {
		key = substr($0, 1, index($0, "=") - 1)
		value = substr($0, index($0, "=") + 1)

		comma = index(value, ",")

		if (comma) {
			metadata = substr(value, comma + 1)
			print key "=none," metadata
		} else {
			print key "=none"
		}

		next
	}

	{
		print
	}
' "$config" > "$temporary"

chmod --reference="$config" "$temporary"
mv "$temporary" "$config"

printf "Backup: %s\n" "$backup"
printf "All current shortcuts set to none.\n"
