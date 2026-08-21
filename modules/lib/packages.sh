#!/usr/bin/env bash

package_exists() {
    xbps-query -p pkgname "$1" >/dev/null 2>&1
}

install_packages() {
    local packages=("$@")
    local missing=()

    for package in "${packages[@]}"; do
        if ! package_exists "$package"; then
            missing+=("$package")
        fi
    done

    if ((${#missing[@]})); then
        sudo xbps-install -y "${missing[@]}"
    fi
}
