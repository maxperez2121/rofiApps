#!/bin/bash

# Rofi CMD
rofi_cmd() {
    rofi -dmenu \
        -p "Stop" \
        -theme $HOME/.config/rofiApps/config.rasi
}
# Rofi message
rofi_msg() {
    rofi -theme $HOME/.config/rofiApps/config.rasi \
        -e "$1"
}

detenerContenedor(){
    contenedor=$(docker ps | sed "1d" | awk '{print $NF}' | rofi_cmd)

    error_message=$(docker stop $contenedor 2>&1)

    if [ $? -eq 0 ]; then
        rofi_msg "$contenedor -> se ha detenido correctamente"
    else
        rofi_msg "Error al detener el contenedor $contenedor: \n $error_message"
    fi
}

verificarVacio(){
    if [ "" == "$(docker ps | sed '1d')" ]; then
        rofi_msg "Ningún contenedor esta corriendo en este momento"
    else
        detenerContenedor
    fi
}

verificarVacio
