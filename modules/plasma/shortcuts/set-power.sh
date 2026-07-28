#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$0")/functions.sh"

bind "org_kde_powerdevil" "Decrease Keyboard Brightness" "Keyboard Brightness Down"
bind "org_kde_powerdevil" "Increase Keyboard Brightness" "Keyboard Brightness Up"
bind "org_kde_powerdevil" "Toggle Keyboard Backlight" "Keyboard Light On/Off"

bind "org_kde_powerdevil" "Decrease Screen Brightness" "Monitor Brightness Down"
bind "org_kde_powerdevil" "Increase Screen Brightness" "Monitor Brightness Up"

bind "org_kde_powerdevil" "Decrease Screen Brightness Small" "Shift+Monitor Brightness Down"
bind "org_kde_powerdevil" "Increase Screen Brightness Small" "Shift+Monitor Brightness Up"

bind "org_kde_powerdevil" "Hibernate" "Hibernate"
bind "org_kde_powerdevil" "Sleep" "Sleep"
bind "org_kde_powerdevil" "PowerDown" "Power Down"
bind "org_kde_powerdevil" "PowerOff" "Power Off"

bind "org_kde_powerdevil" "powerProfile" "Meta+B"
