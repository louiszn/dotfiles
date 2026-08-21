#!/usr/bin/env bash

import_lib kwin_shortcuts

bind "org_kde_powerdevil" "Decrease Keyboard Brightness" "Keyboard Brightness Down"
bind "org_kde_powerdevil" "Increase Keyboard Brightness" "Keyboard Brightness Up"
bind "org_kde_powerdevil" "Toggle Keyboard Backlight" "Keyboard Light On/Off"
bind "org_kde_powerdevil" "Decrease Screen Brightness" "Monitor Brightness Down"
bind "org_kde_powerdevil" "Increase Screen Brightness" "Monitor Brightness Up"
bind "org_kde_powerdevil" "Decrease Screen Brightness Small" "Shift+Monitor Brightness Down"
bind "org_kde_powerdevil" "Increase Screen Brightness Small" "Shift+Monitor Brightness Up"
bind "org_kde_powerdevil" "Turn Off Screen" "Display Off"
bind "org_kde_powerdevil" "Sleep" "Sleep"
bind "org_kde_powerdevil" "Hibernate" "Hibernate"
bind "org_kde_powerdevil" "PowerDown" "Power Down"
bind "org_kde_powerdevil" "PowerOff" "Power Off"
bind "org_kde_powerdevil" "powerProfile" "Meta+B"

bind "kmix" "decrease_volume" "Volume Down"
bind "kmix" "increase_volume" "Volume Up"
bind "kmix" "decrease_volume_small" "Shift+Volume Down"
bind "kmix" "increase_volume_small" "Shift+Volume Up"
bind "kmix" "decrease_microphone_volume" "Microphone Volume Down"
bind "kmix" "increase_microphone_volume" "Microphone Volume Up"
bind "kmix" "mute" "Volume Mute"
bind "kmix" "mic_mute" "Microphone Mute"

bind "mediacontrol" "nextmedia" "Media Next"
bind "mediacontrol" "previousmedia" "Media Previous"
bind "mediacontrol" "playpausemedia" "Media Play"
bind "mediacontrol" "pausemedia" "Media Pause"
bind "mediacontrol" "playmedia" "Media Play"
bind "mediacontrol" "stopmedia" "Media Stop"
bind "mediacontrol" "seekbackwardmedia" "Media Rewind"
bind "mediacontrol" "seekforwardmedia" "Media Fast Forward"

bind "kcm_touchpad" "Disable Touchpad" "Touchpad Off"
bind "kcm_touchpad" "Enable Touchpad" "Touchpad On"
bind "kcm_touchpad" "Toggle Touchpad" "Touchpad Toggle"

bind "kded5" "display" "Display"
bind "kded5" "Show System Activity" "Ctrl+Esc"

bind "ksmserver" "Lock Session" "Meta+L"
bind "ksmserver" "Log Out" "Ctrl+Alt+Delete"