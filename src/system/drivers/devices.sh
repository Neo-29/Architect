source src/cmd.sh

function gamepad() {
    read -rp "${GAMEPAD_XBOX} (${YES_MIN}/N) : " choice
    choice="${choice^^}"

    if [[ $choice == "${YES}" ]]; then
        install_one "xpadneo-dkms"
    fi

    read -rp "${GAMEPAD_PS} (${YES_MIN}/N) : " choice
    choice="${choice^^}"

    if [[ $choice == "${YES}" ]]; then
        uninstall_one "bluez-utils"
        install_lst "ds4drv dualsensectl"
    fi
}

function printer() {
    read -rp "${USE_PRINTER} (${YES_MIN}/N) : " choice
    choice="${choice^^}"

    if [[ $choice == "${YES}" ]]; then
        local inlst="
            ghostscript
            gsfonts
            cups
            cups-filters
            cups-pdf
            system-config-printer
            avahi
            foomatic-db-engine
            foomatic-db
            foomatic-db-ppds
            foomatic-db-nonfree
            foomatic-db-nonfree-ppds
            gutenprint
            foomatic-db-gutenprint-ppds
        "
        read -rp "${USE_EPSON_PRINTER} (${YES_MIN}/N) : " choice
        choice="${choice^^}"

        if [[ $choice == "${YES}" ]]; then
            inlst+="
                epson-inkjet-printer-escpr
                epson-inkjet-printer-escpr2
                epson-inkjet-printer-201601w
                epson-inkjet-printer-n10-nx127
            "
        fi
        read -rp "${USE_HP_PRINTER} (${YES_MIN}/N) : " choice
        choice="${choice^^}"

        if [[ $choice == "${YES}" ]]; then
            inlst+="
                hplip
                python-pyqt5
            "
        fi

        install_lst "${inlst}"

        exec_log "sudo systemctl enable --now avahi-daemon" "e${ENABLING_AVAHI}"
        exec_log "sudo systemctl enable --now cups" "${ENABLING_CUPS}"
    fi
}

function bluetooth() {
    read -rp "${USE_BLUETOOTH} (${YES_MIN}/N) : " choice
    choice="${choice^^}"

    if [[ $choice == "${YES}" ]]; then
        local -r inlst="
            bluez
            bluez-plugins
        "

        install_lst "${inlst}"

        exec_log "pacman -Qi bluez-utils-compat" "${CHECK_BLUEZ}"
        if [[ $? -eq 1 ]]; then
            install_one "bluez-utils"
        fi

        exec_log "sudo systemctl enable --now bluetooth" "${ENABLING_BLUETOOTH}"
    fi
}
