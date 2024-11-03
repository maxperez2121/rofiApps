#!/bin/bash

# Rofi CMD
rofi_cmd() {
    rofi -dmenu \
        -p "My Images" \
        -theme "$HOME/.config/rofiApps/config.rasi"
}
# Rofi message
rofi_msg() {
    rofi -theme "$HOME/.config/rofiApps/config.rasi" \
        -e "$1"
}

obtenerNombreImagen(){
    image=$(docker images | sed "1d" | awk '{print $1":"$2}' | rofi_cmd)
    copiar=$(echo "$image" | xclip -sel clip)

    if mycmd; then
        notify-send 'Se copio en el portapapeles'
    fi
}

verificarVacio(){
    if [ "" == "$(docker images | sed '1d')" ]; then
        rofi_msg "No existe ninguna imagen"
    else
        obtenerNombreImagen
    fi
}
verificarVacio
