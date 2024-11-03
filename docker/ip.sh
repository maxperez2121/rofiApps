#!/bin/bash

# Rofi CMD
rofi_cmd() {
    rofi -dmenu \
        -p "Get IP" \
        -theme $HOME/.config/rofiApps/config.rasi
}
# Rofi message
rofi_msg() {
    rofi -theme $HOME/.config/rofiApps/config.rasi \
        -e "$1"
}

obtenerIpContenedor(){
    contenedor=$(docker ps | sed "1d" | awk '{print $NF}' | rofi_cmd)

    error_message=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $contenedor | xclip -sel clip 2>&1)

    if [ $? -eq 0 ]; then
        rofi_msg "La IP del $contenedor se guardo en el portapapeles"
    else
        rofi_msg "Error al obtener la ip del contenedor $contenedor: \n $error_message"
    fi
}

verificarVacio(){
    if [ "" == "$(docker ps | sed '1d')" ]; then
        rofi_msg "Ningún contenedor esta corriendo en este momento"
    else
        obtenerIpContenedor
    fi
}

verificarVacio
