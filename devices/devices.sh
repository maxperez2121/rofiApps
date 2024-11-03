#!/bin/bash

# Opciones
mount='Montar'
eject='Expulsar'
unmount='Desmontar'
powerOff='Power Off'

# Rofi CMD
rofi_cmd() {
    rofi -dmenu \
        -p "Devices" \
        -theme "$HOME/.config/rofiApps/config.rasi"
}

# Pasar variables a rofi
run_rofi() {
    echo -e "$mount\n$eject\n$unmount\n$powerOff" | rofi_cmd
}

run_cmd() {
    selected="$(run_rofi)"
    if [[ "$selected" == "$mount" ]]; then
        bash "${HOME}/.config/rofiApps/devices/mount.sh"
    elif [[ "$selected" == "$eject" ]]; then
        bash "${HOME}/.config/rofiApps/devices/eject.sh"
    elif [[ "$selected" == "$unmount" ]]; then
        bash "${HOME}/.config/rofiApps/devices/unmount.sh"
    elif [[ "$selected" == "$powerOff" ]]; then
        bash "${HOME}/.config/rofiApps/devices/powerOff.sh"
    fi
}

run_cmd
