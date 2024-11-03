#!/bin/bash

# Rofi CMD
rofi_cmd() {
    rofi -dmenu \
        -p "Exec" \
        -theme $HOME/.config/rofiApps/config.rasi
}
# Rofi message
rofi_msg() {
    rofi -theme $HOME/.config/rofiApps/config.rasi \
        -e "$1"
}

execContenedor(){
    contenedor=$(docker ps | sed "1d" | awk '{print $NF}' | fzf)

    if [ "" == $contenedor ]; then
        tipo=$(echo -e "sh\nbash" | rofi_cmd)

        case $tipo in
            "sh")
                error_message=$(docker exec -it $contenedor sh 2>&1)

                if [ $? -eq 0 ]; then
                    rofi_msg "$contenedor -> se ha detenido correctamente"
                else
                    rofi_msg "Error al detener el contenedor $contenedor: \n $error_message"
                fi
                ;;
            "bash")
                error_message=$(docker exec -it $contenedor bash 2>&1)

                if [ $? -eq 0 ]; then
                    rofi_msg "$contenedor -> se ha detenido correctamente"

                else
                    rofi_msg "Error al detener el contenedor $contenedor: \n $error_message"

                fi
                ;;
        esac
    else
        rofi_msg "No se eligió ningún contenedor" \

        fi
}

verificarVacio(){
    if [ "" == "$(docker ps | sed '1d')" ]; then
        rofi_msg "Ningún contenedor esta corriendo en este momento"
    else
        execContenedor
    fi
}

verificarVacio
