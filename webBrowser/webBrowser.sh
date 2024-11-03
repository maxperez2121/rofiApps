#!/bin/bash

# Opciones
nuevaVentana='Nueva Ventana'
ventaPrivada='Ventana Privada'

# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
		-p "Browser" \
		-theme "$HOME/.config/rofiApps/config.rasi"
}
# Rofi message
rofi_msg() {
    rofi -theme "$HOME/.config/rofiApps/config.rasi" \
        -e "$1"
}
# Pasar variables a rofi
run_rofi() {
	echo -e "$nuevaVentana\n$ventaPrivada" | rofi_cmd
}

run_cmd() {
	selected="$(run_rofi)"
	if [[ "$selected" == "$nuevaVentana" ]]; then
		nueva_ventana
	elif [[ "$selected" == "$ventaPrivada" ]]; then
		ventana_privada
	fi
}

# Navegador
qutebrowser='qutebrowser'
librewolf='librewolf'
firefox='firefox'
googleChrome='google-chrome'
microsoftEdge='microsoft-edge'

rofi_browser() {
	echo -e "$qutebrowser\n$librewolf\n$firefox\n$googleChrome\n$microsoftEdge" | rofi_cmd
}

nueva_ventana() {
	selected="$(rofi_browser)"
	case $selected in
		"$qutebrowser" )
			qutebrowser --target tab
		;;
		"$librewolf" )
			librewolf --new-window
		;;
		"$firefox" )
			firefox --new-window
		;;
		"$googleChrome" )
			google-chrome --new-window
		;;
		"$microsoftEdge" )
		;;
	esac
}
ventana_privada() {
	selected="$(rofi_browser)"
	case $selected in
		"$qutebrowser" )
			qutebrowser --target private-window
		;;
		"$librewolf" )
			librewolf --private-window
		;;
		"$firefox" )
			firefox --private-window
		;;
		"$googleChrome" )
			google-chrome --incognito
		;;
		"$microsoftEdge" )
		;;
	esac
}
run_cmd
#nombre=$(ls -aF ~/.config/rofiApps/docker | grep "*" | awk '{ gsub(" ","\ "); print}' | rofi_cmd)
