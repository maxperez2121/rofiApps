#!/bin/bash

allDevices="/tmp/devicesAllDevices"
autoMounted="/tmp/devicesAutoMounted"

list_mainDevices() {
    fileMain="/tmp/devicesMain"
    fileTempUno="/tmp/devicesTemp"
    fileDiferencia="/tmp/devicesDiferencia"
    fileToMount="/tmp/devicesMount"

    lsblk -p -l -o NAME,TYPE,MOUNTPOINT | awk '$2 == "part" {print $1}' > "$allDevices"

    if [ ! -e "$autoMounted" ]; then
        lsblk -p -l -o NAME,TYPE,MOUNTPOINT | awk '$2 == "part" && $3 != "" {print $1}' > "$autoMounted"
    fi
    #if [ -e "$fileMain" ]; then
    #lsblk -d -p -l -o NAME,MOUNTPOINT | awk '$2 == "" {print $1}' > "$fileTempUno"

    #if [ -n "$(diff $fileMain $fileTempUno)" ]; then
    #diff $fileMain $fileTempUno > "$fileDiferencia"
    #if [ "$(stat -c %s $fileMain)" -gt "$(stat -c %s $fileTempUno)" ]; then
    #lsblk -d -p -l -o NAME,MOUNTPOINT | awk '$2 == "" {print $1}' > "$fileMain"
    #else
    #diff --new-line-format="" --unchanged-line-format="" "$fileTempUno" "$fileMain" | grep -v '^> ' >> "$fileMain"
    #fi
    #fi

    #rm -f "$fileTempUno"
    #else
    #lsblk -d -p -l -o NAME,MOUNTPOINT | awk '$2 == "" {print $1}' > "$fileMain"
    #fi

    cat "$autoMounted"
}

# Rofi CMD
rofi_cmd() {
    rofi -dmenu \
        -theme "$HOME/.config/rofiApps/config.rasi"
}

# Opciones
eject='eject'
mount='mount'
unmount='unmount'
poweroff='power-off'

run_options() {
    echo -e "$eject\n$mount\n$unmount\n$poweroff" | rofi_cmd
}

select_device() {
    list_mainDevices | rofi_cmd
}

run_cmd() {
    opts=$(run_options)
    selected=$(select_device)

    case $opts in
        "$eject")
            udisksctl unmount -b "$selected" && udisksctl power-off -b "$selected"
            ;;
        "$mount")
            udisksctl mount -b "$selected"
            ;;
        "$unmount")
            udisksctl unmount -b "$selected"
            ;;
        "$poweroff")
            udisksctl power-off -b "$selected"
            ;;
    esac
}

run_cmd
