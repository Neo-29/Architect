# source src/cmd.sh

declare -A desktop_list
declare -A system_list
declare -A browser_list
declare -A video_list
declare -A picture_list
declare -A gaming_list

selected_packages=""

function set_software_list() {

    desktop_list=(
        ["Discord"]="discord"
        ["Telegram"]="telegram-desktop"
        ["Spotify"]="spotify"
        ["LibreOffice en"]="libreoffice-fresh"
        ["LibreOffice fr"]="libreoffice-fresh libreoffice-fresh-fr"
        ["OnlyOffice"]="onlyoffice-bin"
        ["Audacity"]="audacity"
        ["Kazam"]="kazam"
        ["Visual Studio Code"]="visual-studio-code-bin"
        ["Visual Studio Code Open Source"]="code"
        ["Virtualbox"]="virtualbox virtualbox-host-dkms virtualbox-guest-iso"
        ["CrossOver"]="crossover"
    )

    system_list=(
        ["Open RGB"]="openrgb"
        ["Arch Update"]="arch-update"
    )

    picture_list=(
        ["Gimp"]="gimp"
        ["Krita"]="krita"
        ["Inkscape"]="inkscape"
        ["Blender"]="blender"
    )

    video_list=(
        ["Kdenlive"]="kdenlive"
        ["OBS Studio"]="obs-studio"
        ["VLC"]="vlc"
        ["MPV"]="mpv"
    )

    browser_list=(
        ["Firefox en"]="firefox"
        ["Firefox fr"]="firefox firefox-i18n-fr"
        ["Brave"]="brave-bin"
        ["Chromium"]="chromium"
        ["Vivaldi"]="vivaldi vivaldi-ffmpeg-codecs"
        ["Google Chrome"]="google-chrome"
        ["Microsoft Edge"]="microsoft-edge-stable-bin"
    )

    gaming_list=(
        ["Steam"]="steam"
        ["Lutris (LOL, etc.)"]="lutris wine-staging "
        ["Heroic Games Launcher (Epic Games, GOG, etc.)"]="heroic-games-launcher-bin"
        ["Prism Launcher (Minecraft)"]="prismlauncher-qt5 jdk8-openjdk"
        ["ProtonUp QT"]="protonup-qt"
        ["Goverlay"]="goverlay"
        ["Gamemode"]="gamemode lib32-gamemode"
    )
}

function select_and_install() {
    declare -n software_list=$1
    local -r software_type=$2
    local i=1
    local options=()
    local input

    eval_gettext "\${GREEN}\${software_type}\${RESET} :"; echo
    for software in "${!software_list[@]}"; do
        printf " ${PURPLE}%2d${RESET}) %s\n" "$i" "$software"
        options+=("$software")
        ((i++))
    done

    eval_gettext "\${BLUE}::\${RESET} Packages to install (e.g., 1 2 3, 1-3, all or press enter to skip): "
    read -ra input

    for item in "${input[@]}"; do
        if [[ "$item" == "$(eval_gettext "all")" ]]; then
            for software in "${!software_list[@]}"; do
                selected_packages+=" ${software_list[$software]} "
            done
            break
        elif [[ $item =~ ^[0-9]+$ ]]; then
            selected_packages+=" ${software_list[${options[$item - 1]}]} "
        elif [[ $item =~ ^[0-9]+-[0-9]+$ ]]; then
            IFS='-' read -ra range <<<"$item"
            for ((j = ${range[0]}; j <= ${range[1]}; j++)); do
                selected_packages+=" ${software_list[${options[$j - 1]}]} "
            done
        fi
    done
}

function install_software() {
    set_software_list

    select_and_install browser_list "$(eval_gettext "Browsers")"
    select_and_install system_list "$(eval_gettext "System Software")"
    select_and_install desktop_list "$(eval_gettext "Desktop Apps")"
    select_and_install video_list "$(eval_gettext "Video Software")"
    select_and_install picture_list "$(eval_gettext "Image Editors")"
    select_and_install gaming_list "$(eval_gettext "Gaming Software")"

    local -r aur_packages="${selected_packages}"

    selected_packages=""

    install_lst "${aur_packages}" "aur"

    if [[ "${aur_packages}" =~ "arch-update" ]]; then
        exec_log "systemctl --user enable arch-update.timer" "$(eval_gettext "Enable arch-update.timer")"
        exec_log "arch-update --tray --enable" "$(eval_gettext "Enable arch-update tray")"
    fi
    
    if [[ "${aur_packages}" =~ "virtualbox" ]]; then
        exec_log "sudo usermod -aG vboxusers $SUDO_USER" "$(eval_gettext "Add the current user to the vboxusers group")"
        exec_log "sudo systemctl enable vboxweb.service" "$(eval_gettext "Enable vboxweb")"
    fi

    if [[ "${aur_packages}" =~ "gamemode" ]]; then
        exec_log "sudo usermod -aG gamemode $SUDO_USER" "$(eval_gettext "Add the current user to the gamemode group")"
        
        # Add gamemode configuration
        config_content='[general]
        ; The reaper thread will check every 5 seconds for exited clients, for config file changes, and for the CPU/iGPU power balance
        reaper_freq=5
        
        ; The desired governor is used when entering GameMode instead of "performance"
        desiredgov=performance
        ; The default governor is used when leaving GameMode instead of restoring the original value
        ;defaultgov=powersave
        
        ; The iGPU desired governor is used when the integrated GPU is under heavy load
        igpu_desiredgov=powersave
        ; Threshold to use to decide when the integrated GPU is under heavy load.
        ; This is a ratio of iGPU Watts / CPU Watts which is used to determine when the
        ; integraged GPU is under heavy enough load to justify switching to
        ; igpu_desiredgov.  Set this to -1 to disable all iGPU checking and always
        ; use desiredgov for games.
        igpu_power_threshold=0.3
        
        ; GameMode can change the scheduler policy to SCHED_ISO on kernels which support it (currently
        ; not supported by upstream kernels). Can be set to "auto", "on" or "off". "auto" will enable
        ; with 4 or more CPU cores. "on" will always enable. Defaults to "off".
        softrealtime=off
        
        ; GameMode can renice game processes. You can put any value between 0 and 20 here, the value
        ; will be negated and applied as a nice value (0 means no change). Defaults to 0.
        ; To use this feature, the user must be added to the gamemode group (and then rebooted):
        ; sudo usermod -aG gamemode $SUDO_USER
        renice=0
        
        ; By default, GameMode adjusts the iopriority of clients to BE/0, you can put any value
        ; between 0 and 7 here (with 0 being highest priority), or one of the special values
        ; "off" (to disable) or "reset" (to restore Linux default behavior based on CPU priority),
        ; currently, only the best-effort class is supported thus you cannot set it here
        ioprio=0
        
        ; Sets whether gamemode will inhibit the screensaver when active
        ; Defaults to 1
        inhibit_screensaver=1
        
        ; Sets whether gamemode will disable split lock mitigation when active
        ; Defaults to 1
        disable_splitlock=1
        
        [filter]
        ; If "whitelist" entry has a value(s)
        ; gamemode will reject anything not in the whitelist
        ;whitelist=RiseOfTheTombRaider
        
        ; Gamemode will always reject anything in the blacklist
        ;blacklist=HalfLife3
        ;    glxgears
        
        [gpu]
        ; Here Be Dragons!
        ; Warning: Use these settings at your own risk
        ; Any damage to hardware incurred due to this feature is your responsibility and yours alone
        ; It is also highly recommended you try these settings out first manually to find the sweet spots
        
        ; Setting this to the keyphrase "accept-responsibility" will allow gamemode to apply GPU optimisations such as overclocks
        ;apply_gpu_optimisations=0
        
        ; The DRM device number on the system (usually 0), ie. the number in /sys/class/drm/card0/
        ;gpu_device=0
        
        ; Nvidia specific settings
        ; Requires the coolbits extension activated in nvidia-xconfig
        ; This corresponds to the desired GPUPowerMizerMode
        ; "Adaptive"=0 "Prefer Maximum Performance"=1 and "Auto"=2
        ; See NV_CTRL_GPU_POWER_MIZER_MODE and friends in https://github.com/NVIDIA/nvidia-settings/blob/master/src/libXNVCtrl/NVCtrl.h
        ;nv_powermizer_mode=1
        
        ; These will modify the core and mem clocks of the highest perf state in the Nvidia PowerMizer
        ; They are measured as Mhz offsets from the baseline, 0 will reset values to default, -1 or unset will not modify values
        ;nv_core_clock_mhz_offset=0
        ;nv_mem_clock_mhz_offset=0
        
        ; AMD specific settings
        ; Requires a relatively up to date AMDGPU kernel module
        ; See: https://dri.freedesktop.org/docs/drm/gpu/amdgpu.html#gpu-power-thermal-controls-and-monitoring
        ; It is also highly recommended you use lm-sensors (or other available tools) to verify card temperatures
        ; This corresponds to power_dpm_force_performance_level, "manual" is not supported for now
        ;amd_performance_level=high
        
        [cpu]
        ; Parking or Pinning can be enabled with either "yes", "true" or "1" and disabled with "no", "false" or "0".
        ; Either can also be set to a specific list of cores to park or pin, comma separated list where "-" denotes
        ; a range. E.g "park_cores=1,8-15" would park cores 1 and 8 to 15.
        ; The default is uncommented is to disable parking but enable pinning. If either is enabled the code will
        ; currently only properly autodetect Ryzen 7900x3d, 7950x3d and Intel CPU:s with E- and P-cores.
        ;park_cores=no
        ;pin_cores=yes
        
        [supervisor]
        ; This section controls the new gamemode functions gamemode_request_start_for and gamemode_request_end_for
        ; The whilelist and blacklist control which supervisor programs are allowed to make the above requests
        ;supervisor_whitelist=
        ;supervisor_blacklist=
        
        ; In case you want to allow a supervisor to take full control of gamemode, this option can be set
        ; This will only allow gamemode clients to be registered by using the above functions by a supervisor client
        ;require_supervisor=0
        
        [custom]
        ; Custom scripts (executed using the shell) when gamemode starts and ends
        ;start=notify-send "GameMode started"
        ;    /home/me/bin/stop_foldingathome.sh
        
        ;end=notify-send "GameMode ended"
        ;    /home/me/bin/start_foldingathome.sh
        
        ; Timeout for scripts (seconds). Scripts will be killed if they do not complete within this time.
        ;script_timeout=10
        '

     if [ ! -f /etc/gamemode.ini ]; then
        echo "$config_content" | sudo tee /etc/gamemode.ini > /dev/null
    fi
fi

}
