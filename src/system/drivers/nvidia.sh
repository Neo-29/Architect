source src/cmd.sh

function nvidia_config() {
    # hook
    exec_log "sudo mkdir -p /etc/pacman.d/hooks/" "${HOOK_FOLDER_CREATION}"
    exec_log "sudo cp assets/data/nvidia.hook /etc/pacman.d/hooks/nvidia.hook" "${HOOK_FILE_COPY}"

    # mkinitcpio
    exec_log "sudo sed -i '/MODULES=/ s/)/ nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' '/etc/mkinitcpio.conf'" "${MKINITCPIO_CONF}"

    # bootloader
    if [[ ${BOOT_LOADER} == "grub" ]]; then
        exec_log "sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT='\''nowatchdog nvme_load=YES loglevel=3'\''/GRUB_CMDLINE_LINUX_DEFAULT='\''nowatchdog nvme_load=YES loglevel=3 nvidia-drm.modeset=1'\''/' /etc/default/grub" "${GRUB_CONF}"
        exec_log "sudo grub-mkconfig -o /boot/grub/grub.cfg" "${GRUB_UPDATE}"
    else
        exec_log "sudo sed -i '/^options/ s/$/ nvidia-drm.modeset=1/' /boot/loader/entries/*.conf" "${SYSTEMD_BOOT_CONF}"
    fi
}

function nvidia_drivers() {
    local -r unlst="
        nvidia-dkms
        nvidia-settings
        nvidia-utils
        opencl-nvidia
        libvdpau
        lib32-libvdpau
        lib32-libvdpau
        lib32-nvidia-utils
        egl-wayland
        dxvk-nvapi-mingw
        libxnvctrl
        lib32-libxnvctrl
        vulkan-icd-loader
        lib32-vulkan-icd-loader
        lib32-opencl-nvidia
        opencl-headers
        lib32-nvidia-dev-utils-tkg
        lib32-opencl-nvidia-dev-tkg
        nvidia-dev-dkms-tkg
        nvidia-dev-egl-wayland-tkg
        nvidia-dev-settings-tkg
        nvidia-dev-utils-tkg
        opencl-nvidia-dev-tkg
    "

    uninstall_lst "${unlst}" "${NVIDIA_DEPS_CLEANING}"

    read -rp "${USE_NVIDIA_ALL} ${RED}/!\ ${NVIDIA_ALL_WARNING}${RESET} ? (${YES_MIN}/N) : " user_nvidia_all
    user_nvidia_all="${user_nvidia_all^^}"

    nvidia_config
    if [[ ${user_nvidia_all} == "${YES}" ]]; then
        exec_log "git clone https://github.com/Frogging-Family/nvidia-all.git" "${NVIDIA_ALL_CLONING}"
        cd nvidia-all || exit
        makepkg -si --noconfirm
        cd .. || exit
        exec_log "rm -rf nvidia-all" "${NVIDIA_ALL_REMOVAL}"
        install_one "cuda"

    else
        local -r inlst="
            nvidia-dkms
            nvidia-utils
            lib32-nvidia-utils
            nvidia-settings
            vulkan-icd-loader
            lib32-vulkan-icd-loader
            cuda
        "
        install_lst "${inlst}"
    fi

    exec_log "sudo systemctl enable nvidia-{hibernate,resume,suspend}" "${ENABLING_NVIDIA}"
}
