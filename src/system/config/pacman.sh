source src/cmd.sh

function config_pacman() {
    exec_log "sudo sed -i 's/^#Color$/Color/' '/etc/pacman.conf'" "${ENABLING_COLOR}"
    exec_log "sudo sed -i 's/^#VerbosePkgLists$/VerbosePkgLists/' '/etc/pacman.conf'" "${ENABLING_VERBOSE}"
    exec_log "sudo sed -i 's/^#\(ParallelDownloads.*\)/\1/' '/etc/pacman.conf'" "${ENABLING_PARALLEL}"
    exec_log "sudo sed -i '/^#\[multilib\]/,/^#Include = \/etc\/pacman.d\/mirrorlist/ s/^#//' '/etc/pacman.conf'" "${ENABLING_MULTILIB}"
}

function mirrorlist() {
    install_one "reflector"
    exec_log "sudo reflector --verbose --score 20 --fastest 5 --sort rate --save /etc/pacman.d/mirrorlist" "${UPDATING_MIRRORS}"
    exec_log "sudo pacman -Syy" "${UPDATING_DATABASE}"
}
