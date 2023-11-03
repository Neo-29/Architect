#!/usr/bin/env bash

# ================================================================================================ #
export RESET=$(tput sgr0)
export RED=$(tput setaf 1)
export GREEN=$(tput setaf 2)
export YELLOW=$(tput setaf 3)
export BLUE=$(tput setaf 4)
export PURPLE=$(tput setaf 5)
# ================================================================================================ #
if sudo -v; then
    echo -e "\n${GREEN}${ROOT_PRIVILEGES_GRANTED}${RESET}"
else
    echo -e "\n${RED}${ROOT_PRIVILEGES_DENIED}${RESET}"
    exit 1
fi
# ================================================================================================ #
if [[ $1 == "-v" ]]; then
    export VERBOSE=true
else
    export VERBOSE=false
fi
# ================================================================================================ #
export LOG_FILE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/logfile_$(date "+%Y%m%d-%H%M%S").log"
if [[ -d "/boot/loader/entries" ]]; then
    export BOOT_LOADER="systemd-boot"
else
    export BOOT_LOADER="grub"
fi
if [[ $(lsblk -o FSTYPE | grep -c btrfs) -gt 0 ]]; then
    export BTRFS=true
else
    export BTRFS=false
fi
# ================================================================================================ #
source src/init.sh
source src/end.sh
source src/de/detect.sh
source src/software/flatpak.sh
source src/software/install.sh
source src/system/config/aur.sh
source src/system/config/pacman.sh
source src/system/drivers/devices.sh
source src/system/drivers/gpu.sh
source src/system/kernel.sh
source src/system/other.sh
source src/system/packages.sh
source src/system/shell.sh
# ================================================================================================ #
function print_center() {
    local -r message="$1"
    local -r color="$2"
    local -r line="-----------------------------------------------------------------------------------------------------------"
    local -r line_length=${#line}
    local -r message_length=${#message}
    
    local -r total_padding=$((line_length - message_length))
    local -r padding_side=$((total_padding / 2))
    local padding_right=$padding_side

    if [ $((total_padding % 2)) -ne 0 ]; then
        ((padding_right++))
    fi

    printf "%s%b%s%b%s\n" \
        "${line:0:padding_side}" \
        "${color}" "$message" "${RESET}" \
        "${line:0:padding_right}"
}

function little_step() {
    local -r function=$1
    local -r message=$2

    print_center "${message}" "${YELLOW}"
    ${function}
}
# ================================================================================================ #
function main() {
    local -r start_time="$(date +%s)"
    # init
    print_center "${INITIALIZATION}" "${GREEN}"
    init_log
    language_conf
    header

    # system
    print_center "${SYSTEM_PREP}" "${GREEN}"
    little_step config_pacman           "${PACMAN_CONF}"
    little_step install_aur             "${AUR_HELPER_INST}"
    little_step mirrorlist              "${MIRRORLIST_CONF}"
    little_step install_headers         "${KERNEL_HEADERS_INST}"
    little_step max_map_count           "${MAX_MAP_COUNT_CONF}"
    little_step sound_server            "${SOUND_SERVER_CONF}"
    little_step setup_system_loaders    "${BOOTLOADERS_CONF}"
    little_step usefull_package         "${USEFUL_PACKAGES_INST}"
    little_step shell_config            "${SHELL_CONF}"

    # drivers
    print_center "${SYSTEM_CONF}" "${GREEN}"
    little_step video_drivers           "${VIDEO_DRIVERS_INST}"
    little_step gamepad                 "${GAMEPAD_CONF}"
    little_step printer                 "${PRINTER_CONF}"
    little_step bluetooth               "${BLUETOOTH_CONF}"

    # desktop environment
    print_center "${DE_CONF}" "${GREEN}"
    little_step detect_de               "${DE_DETECTION}"

    # software
    print_center "${SOFTWARE_INST}" "${GREEN}"
    little_step support_flatpak         "${FLATPAK_SUPPORT_INST}"
    little_step install_software        "${SOFTWARE_INST}"

    # end
    endscript "${start_time}"
}
# ================================================================================================ #
main
