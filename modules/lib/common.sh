#!/usr/bin/env bash

set -euo pipefail

import_lib() {
    local lib

    for lib in "$@"; do
        lib="$ROOT/modules/lib/$lib.sh"

        if [[ ! -f "$lib" ]]; then
            printf 'Library not found: %s\n' "$lib" >&2
            return 1
        fi

        source "$lib"
    done
}

command_exists() {
    local command

    for command in "$@"; do
        if ! command -v "$command" >/dev/null 2>&1; then
            return 1
        fi
    done

    return 0
}
