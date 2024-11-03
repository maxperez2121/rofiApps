#!/bin/bash

# Rofi CMD
rofi_cmd() {
    rofi -dmenu \
        -p "Start" \
        -theme $HOME/.config/rofiApps/config.rasi
}
# Rofi message
rofi_msg() {
    rofi -theme $HOME/.config/rofiApps/config.rasi \
        -e "$1"
}

iniciarContenedor(){
    contenedor=$(docker ps -a | sed "1d" | sed '/Up /d' | awk '{print $NF}' | rofi_cmd)

    error_message=$(docker start $contenedor 2>&1)

    if [ $? -eq 0 ]; then
        rofi_msg "$contenedor -> se ha niciado correctamente"
    else
        rofi_msg "Error al iniciar el contenedor $contenedor: \n $error_message"
    fi
}

iniciarContenedor
