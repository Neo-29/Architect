# src/init.sh

SCRIPT_DESC="Script Architect pour Arch Linux"
BY="Par"
AND=" et"
CHANGES_WARNING="Ce script va effectuer des changements sur votre système."
DURATION_WARNING="Quelques étapes peuvent être plus longues que les autres, en fonction de votre connexion Internet et de votre processeur."
PRESS="Appuyez sur"
ENTER="Entrée"
TO_CONTINUE="pour continuer"
OR="ou"
TO_CANCEL="pour annuler"

# architect.sh

ROOT_PRIVILEGES_GRANTED="Privilèges administrateur accordés"
ROOT_PRIVILEGES_DENIED="Privilèges administrateur refusés"

INITIALIZATION="Initialisation"

SYSTEM_PREP="Préparation du système"
PACMAN_CONF="Configuration de pacman"
AUR_HELPER_INST="Installation d'assistant AUR"
MIRRORLIST_CONF="Configuration des miroirs"
KERNEL_HEADERS_INST="Installation des fichiers en-tête du noyau"
MAX_MAP_COUNT_CONF="Configuration du 'Max map count'"
SOUND_SERVER_CONF="Configuration du serveur de son"
BOOTLOADERS_CONF="Configuration des chargeurs d'amorçage"
USEFUL_PACKAGES_INST="Installation de paquets utiles"
SHELL_CONF="Configuration du shell"

SYSTEM_CONF="Configuration du système"

VIDEO_DRIVERS_INST="Installation des pilotes graphiques"
GAMEPAD_CONF="Configuration des manettes"
PRINTER_CONF="Configuration des imprimantes"
BLUETOOTH_CONF="Configuration du Bluetooth"

DE_CONF="Configuration de l'environnement de bureau"

DE_DETECTION="Détection de l'environnement de bureau"

SOFTWARE_INST="Installation de logiciels"

FLATPAK_SUPPORT_INST="Installation du support des Flatpaks"

# src/system/config/pacman.sh

ENABLING_COLOR="Activation de la couleur dans pacman"
ENABLING_VERBOSE="Activation des listes de paquets complètes dans pacman"
ENABLING_PARALLEL="Activation des téléchargements en parallèle dans pacman"
ENABLING_MULTILIB="Activation du dépôt multilib"
UPDATING_MIRRORS="mise à jour de la liste des miroirs"
UPDATING_DATABASE="mise à jour de la base de données de pacman"

# src/system/config/aur.sh

AUR_CHOICE="Quel assistant AUR souhaitez-vous installer ?"
YOU_CHOSE="Vous avez choisi"
CLONING="Clonage de"
INSTALLATION="Installation de"
DIR_DELETION="Suppression du répertoire"
CONFIG_OF="configuration de"

# src/system/kernel.sh

SETTING="Réglage de"
SETTING_TO="sur"

# src/system/other.sh

SOUND_SERVER_CLEANING="Nettoyage des anciennes dépendances du serveur son"
GRUB_CHECKING="Vérification de l'installation de GRUB"
CREATING_HOOKS="Création de /etc/pacman.d/hooks/"
COPYING_HOOK="Copie de grub.hook vers /etc/pacman.d/hooks/"

# src/system/shell.sh

SHELL_CHOICE="Que souhaitez-vous avoir comme shell par défaut ?"
CHANGING_DEFAULT_SHELL="Changement du shell par défaut en"

# src/system/drivers/gpu.sh

GRAPHICS_CARD_CHOICE="Quel est le fabricant de votre carte graphique ?"

# src/system/drivers/devices.sh

GAMEPAD_XBOX="Voulez-vous utiliser des manettes Xbox 360, Series X|S|Elite ou 8BitDo ?"
YES="O"
YES_MIN="o"
GAMEPAD_PS="Voulez-vous utiliser des manettes PS4 ou PS5 ?"
USE_PRINTER="Voulez-vous utiliser une imprimante ?"
USE_EPSON_PRINTER="Voulez-vous utiliser une imprimante EPSON ?"
USE_HP_PRINTER="Voulez-vous utiliser une imprimante HP ?"
ENABLING_AVAHI="activation du service avahi-daemon"
ENABLING_CUPS="activation du service cups"
USE_BLUETOOTH="Voulez-vous utiliser le Bluetooth ?"
CHECK_BLUEZ="vérification de l'installation de bluez-utils-compat"
ENABLING_BLUETOOTH="activation du service bluetooth"

# src/system/drivers/nvidia.sh

HOOK_FOLDER_CREATION="Création du dossier des hooks"
HOOK_FILE_COPY="Copie du fichier hook"
MKINITCPIO_CONF="configuration de mkinitcpio"
GRUB_CONF="configuration de grub"
GRUB_UPDATE="mise à jour de GRUB"
SYSTEMD_BOOT_CONF="configuration de systemd-boot"
NVIDIA_DEPS_CLEANING="Nettoyage des dépendances des anciens pilotes nvidia"
USE_NVIDIA_ALL="Voulez-vous utiliser NVIDIA-ALL"
NVIDIA_ALL_WARNING="attention: si vous choisissez nvidia-all, vous devrez savoir comment le maintenir."
NVIDIA_ALL_CLONING="clonage du dépôt nvidia-all"
NVIDIA_ALL_REMOVAL="suppression du dépôt nvidia-all"
ENABLING_NVIDIA="activation de nvidia-{hibernate,resume,suspend}"