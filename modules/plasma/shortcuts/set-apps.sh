#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$0")/functions.sh"

bind_app "org.kde.konsole.desktop" "Meta+T"
bind_app "org.kde.krunner.desktop" "Meta+R"
bind_app "org.kde.dolphin.desktop" "Meta+E"
