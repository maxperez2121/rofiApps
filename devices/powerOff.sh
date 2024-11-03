#!/bin/bash

# Rofi CMD
rofi_cmd() {
    rofi -dmenu \
        -p "Power Off" \
        -theme $HOME/.config/rofiApps/config.rasi
}
# Rofi message
rofi_msg() {
    rofi -theme $HOME/.config/rofiApps/config.rasi \
        -e "$1"
}

listDevices=$(lsblk -l | awk '$6 == "part"')
powerOff(){
    runList=$(echo -e "$listDevices" | rofi_cmd)
    cutList=$(echo $runList | awk '{print $1}' )
    error_message=$(udisksctl power-off -b /dev/$cutList 2>&1)

    if [ $? -eq 0 ]; then
        rofi_msg "$cutList -> se ha apagado correctamente"
    else
        rofi_msg "Error al apagar"
    fi
}

verificarVacio(){
    if [ "" == "$listDevices" ]; then
        rofi_msg "No hay ningún nuevo dispositivo conectado recientemente"
    else
        powerOff
    fi
}

verificarVacio
