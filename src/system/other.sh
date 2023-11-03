source src/cmd.sh

function sound_server() {
    local -r unlst="
        pulseaudio
        pulseaudio-bluetooth
        pulseaudio-alsa
        jack2
        pipewire-media-session
    "
    local -r inlst="
        pipewire
        lib32-pipewire
        pipewire-pulse
        pipewire-alsa
        pipewire-jack
        wireplumber
        alsa-utils
        alsa-firmware
        alsa-tools
    "

    uninstall_lst "${unlst}" "${SOUND_SERVER_CLEANING}"
    install_lst "${inlst}"
}

function setup_system_loaders() {
    log_msg "${GRUB_CHECKING}"
    if [[ $BOOT_LOADER != "grub" ]]; then
        return
    fi

    exec_log "sudo mkdir -p '/etc/pacman.d/hooks/'" "${CREATING_HOOKS}"
    exec_log "sudo cp 'assets/data/grub.hook' '/etc/pacman.d/hooks/'" "${COPYING_HOOK}"
    install_one "update-grub"
}

function firewall() {
    read -rp "Do you want to install a firewall /!\ Install and activate firewalld? The default configuration may block access to printers and other devices on your local network ? (y/N) : " choice
    choice="${choice,,}"

    if [[ $choice =~ ^(yes|y)$ ]]; then
        install_lst "firewalld python-pyqt5 python-capng"
        exec_log "sudo systemctl enable --now firewalld.service" "Enabling firewalld"
    fi
}
