BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

source "$BASE_DIR/src/utils.sh"

# Adds an alias to update Arch Linux system using pacman, yay, and flatpak.
# The alias is added to the specified file if it exists and the alias is not already present.
# If the file does not exist, it is created and the alias is added to it.
# Parameters:
#   $1: The file to add the alias to.
function add_alias_u() {
    local file=$1
    local alias_update
    local alias_clean

    if [[ "$AUR_HELPER" == "yay" ]]; then
        alias_update="alias update-arch='yay -Syyu && flatpak update'"
        alias_clean="alias clean-arch='yay -Sc && yay -Yc && flatpak remove --unused'"
    elif [[ "$AUR_HELPER" == "paru" ]]; then
        alias_update="alias update-arch='paru -Syyu && flatpak update'"
        alias_clean="alias clean-arch='paru -Sc && paru -c && flatpak remove --unused'"
    fi

    local alias_key="alias fix-key='sudo rm /var/lib/pacman/sync/* && sudo rm -rf /etc/pacman.d/gnupg/* && sudo pacman-key --init && sudo pacman-key --populate && sudo pacman -Sy --noconfirm archlinux-keyring'"

    if [[ -f "${file}" ]]; then
        local alias_found=$(cat "${file}" | grep "${alias_update}")
        if [[ -z "${alias_found}" ]]; then
            echo "${alias_update}" >> "${file}"
            echo "${alias_clean}" >> "${file}"
            echo "${alias_key}" >> "${file}"
        fi
    else
        echo "${alias_update}" >> "${file}"
        echo "${alias_clean}" >> "${file}"
        echo "${alias_key}" >> "${file}"
    fi
}

# Function to detect and configure the shell
# If the current shell is not fish, it prompts the user to switch to fish shell
# If the user agrees, it installs fish shell, sets it as the default shell, and adds an alias for updating Arch Linux
# If the user disagrees, it adds an alias for updating Arch Linux to the bashrc file
function chose_shell() {
    echo "Détection de fish..."
    if ! echo "${SHELL}" | grep fish &> /dev/null; then
        if read_user "Voulez-vous utiliser fish comme terminal ?"; then
            echo "Configuration du shell."
            echo "|- Installation de fish."
            sudo pacman -S --noconfirm fish man-db man-pages >> /dev/null 2>&1
            echo "|- Changement du shell par défaut."
            chsh -s /usr/bin/fish
            fish -c "fish_update_completions" >> /dev/null 2>&1
            echo "|- Ajout des alias update-arch, clean-arch et fix-key."
            add_alias_u "${HOME}/.config/fish/config.fish"
            fish -c "set -U fish_greeting" >> /dev/null 2>&1
        else
            add_alias_u "${HOME}/.bashrc"
        fi
    fi
    echo "--------------------------------------------------"
}
