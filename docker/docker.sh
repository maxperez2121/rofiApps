#!/bin/bash

# Opciones
start='Start'
stop='Stop'
exec='Exec'
rm='RM container'
rmi='RM image'
ip='Get ip address'
myImagesName='Get my image name'

# Rofi CMD
rofi_cmd() {
    rofi -dmenu \
        -p "Docker" \
        -theme "$HOME/.config/rofiApps/config.rasi"
}

# Pasar variables a rofi
run_rofi() {
    echo -e "$start\n$stop\n$exec\n$rm\n$rmi\n$ip\n$myImagesName" | rofi_cmd
}

run_cmd() {
    selected="$(run_rofi)"
    if [[ "$selected" == "$start" ]]; then
        bash "${HOME}/.config/rofiApps/docker/start.sh"
    elif [[ "$selected" == "$stop" ]]; then
        bash "${HOME}/.config/rofiApps/docker/stop.sh"
    elif [[ "$selected" == "$exec" ]]; then
        bash "${HOME}/.config/rofiApps/docker/exec.sh"
    elif [[ "$selected" == "$rm" ]]; then
        bash "${HOME}/.config/rofiApps/docker/rm.sh"
    elif [[ "$selected" == "$rmi" ]]; then
        bash "${HOME}/.config/rofiApps/docker/rmi.sh"
    elif [[ "$selected" == "$ip" ]]; then
        bash "${HOME}/.config/rofiApps/docker/ip.sh"
    elif [[ "$selected" == "$myImagesName" ]]; then
        bash "${HOME}/.config/rofiApps/docker/myImagesName.sh"
    fi
}

run_cmd

#nombre=$(ls -aF ~/.config/rofiApps/docker | grep "*" | awk '{ gsub(" ","\ "); print}' | rofi_cmd)
