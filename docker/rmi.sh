#!/bin/bash

# Rofi CMD
rofi_cmd() {
    rofi -dmenu \
        -p "RMi" \
        -theme $HOME/.config/rofiApps/config.rasi
}

borrarImagen(){
    contenedor=$(docker images | sed "1d" | awk '{print $1":"$2}' | rofi_cmd)

    error_message=$(docker rm $contenedor 2>&1)

    if [ $? -eq 0 ]; then
        rofi -e "$contenedor -> se ha borrado correctamente" -theme $HOME/.config/rofiApps/config.rasi
    else
        rofi -e "Error al borrar la imagen $contenedor: \n $error_message" -theme $HOME/.config/rofiApps/config.rasi
    fi
}

verificarVacio(){
    if [ "" == "$(docker images | sed '1d')" ]; then
        rofi -e "No existe ninguna imagen para borrar" -theme $HOME/.config/rofiApps/config.rasi
    else
        borrarImagen
    fi
}

verificarVacio
