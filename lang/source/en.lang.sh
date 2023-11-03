# src/init.sh

SCRIPT_DESC="Script Architect for Arch Linux"
BY=" By"
AND="and"
CHANGES_WARNING="This script will make changes to your system."
DURATION_WARNING="Some steps may take longer, depending on your Internet connection and CPU."
PRESS="Press"
ENTER="Enter"
TO_CONTINUE="to continue"
OR="or"
TO_CANCEL="to cancel"

# architect.sh

ROOT_PRIVILEGES_GRANTED="Root privileges granted"
ROOT_PRIVILEGES_DENIED="Root privileges denied"

INITIALIZATION="Initialization"

SYSTEM_PREP="System preparation"
PACMAN_CONF="Pacman configuration"
AUR_HELPER_INST="AUR helper installation"
MIRRORLIST_CONF="Mirrorlist configuration"
KERNEL_HEADERS_INST="Kernel headers installation"
MAX_MAP_COUNT_CONF="'Max map count' configuration"
SOUND_SERVER_CONF="Sound server configuration"
BOOTLOADERS_CONF="Bootloaders configuration"
USEFUL_PACKAGES_INST="Useful packages installation"
SHELL_CONF="Shell configuration"

SYSTEM_CONF="System configuration"

VIDEO_DRIVERS_INST="Video drivers installation"
GAMEPAD_CONF="Gamepad configuration"
PRINTER_CONF="Printer configuration"
BLUETOOTH_CONF="Bluetooth configuration"

DE_CONF="Desktop environment configuration"

DE_DETECTION="Desktop environment detection"

SOFTWARE_INST="Software installation"

FLATPAK_SUPPORT_INST="Flatpak support installation"

# src/system/config/pacman.sh

ENABLING_COLOR="Enabling color in pacman"
ENABLING_VERBOSE="Enabling verbose package lists in pacman"
ENABLING_PARALLEL="Enabling parallel downloads in pacman"
ENABLING_MULTILIB="Enabling multilib repository"
UPDATING_MIRRORS="updating mirrorlist"
UPDATING_DATABASE="updating pacman database"

# src/system/config/aur.sh

AUR_CHOICE="What aur helper do you want to install ?"
YOU_CHOSE="You chose"
CLONING="Cloning of"
INSTALLATION="Installation of"
DIR_DELETION="Directory deletion"
CONFIG_OF="configuration of"

# src/system/kernel.sh

SETTING="Setting"
SETTING_TO="to"

# src/system/other.sh

SOUND_SERVER_CLEANING="Cleaning old sound server dependencies"