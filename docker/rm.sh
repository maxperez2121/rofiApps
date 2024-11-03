#!/bin/bash

# Rofi CMD
rofi_cmd() {
    rofi -dmenu \
        -p "RM" \
        -theme $HOME/.config/rofiApps/config.rasi
}

borrarContenedor(){
    contenedor=$(docker ps -a | sed "1d" | awk '{print $NF}' | rofi_cmd)

    error_message=$(docker rm $contenedor 2>&1)

    if [ $? -eq 0 ]; then
        rofi -e "$contenedor -> se ha borrado correctamente" -theme $HOME/.config/rofiApps/config.rasi
    else
        rofi -e "Error al borrar el contenedor $contenedor: \n $error_message" -theme $HOME/.config/rofiApps/config.rasi
    fi
}

verificarVacio(){
    if [ "" == "$(docker ps -a | sed '1d')" ]; then
        rofi -e "No existe ningun contendor para borrar" -theme $HOME/.config/rofiApps/config.rasi
    else
        borrarContenedor
    fi
}

verificarVacio
