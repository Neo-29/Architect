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