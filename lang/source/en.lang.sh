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
GRUB_CHECKING="Checking if GRUB is installed"
CREATING_HOOKS="Creating /etc/pacman.d/hooks/"
COPYING_HOOK="Copying grub.hook to /etc/pacman.d/hooks/"

# src/system/shell.sh

SHELL_CHOICE="What would you like to be your default shell ?"
CHANGING_DEFAULT_SHELL="Setting default shell to"

# src/system/drivers/gpu.sh

GRAPHICS_CARD_CHOICE="What is your graphics card type ?"

# src/system/drivers/devices.sh

GAMEPAD_XBOX="Do you want to use Xbox 360, Series X|S|Elite or 8BitDo controllers ?"
YES="Y"
YES_MIN="y"
GAMEPAD_PS="Do you want to use PS4 or PS5 controllers ?"
USE_PRINTER="Do you want to use a printer ?"
USE_EPSON_PRINTER="Do you want to use a EPSON printer ?"
USE_HP_PRINTER="Do you want to use a HP printer ?"
ENABLING_AVAHI="enabling avahi-daemon service"
ENABLING_CUPS="enabling cups service"
USE_BLUETOOTH="Do you want to use Bluetooth ?"
CHECK_BLUEZ="checking if bluez-utils-compat is installed"
ENABLING_BLUETOOTH="enabling bluetooth service"

# src/system/drivers/nvidia.sh

HOOK_FOLDER_CREATION="Hook folder creation"
HOOK_FILE_COPY="Hook file copy"
MKINITCPIO_CONF="mkinitcpio configuration"
GRUB_CONF="grub configuration"
GRUB_UPDATE="GRUB update"
SYSTEMD_BOOT_CONF="systemd-boot configuration"
NVIDIA_DEPS_CLEANING="Cleaning old nvidia drivers dependencies"
USE_NVIDIA_ALL="Do you want to use NVIDIA-ALL"
NVIDIA_ALL_WARNING="caution: if you choose nvidia-all, you'll need to know how to maintain it."
NVIDIA_ALL_CLONING="cloning of nvidia-all repository"
NVIDIA_ALL_REMOVAL="removal of nvidia-all repository"
ENABLING_NVIDIA="activation of nvidia-{hibernate,resume,suspend}"

# DE Translations

ASK_DE="What is your desktop environment ?"

SETTING_ADW_GTK3="Setting gtk theme to adw-gtk3"
ENABLING_NUMLOCK="Enabling numlock on startup"
UPDATING_USER_DIRS="Updating user directories"

# src/software/flatpak.sh

ADD_FLATHUB="add flathub repository"

# src/software/install.sh

ASK_INSTALL="Do you want to install"