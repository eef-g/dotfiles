#!/usr/bin/env bash

############################################
#  				Global Vars				   #
############################################
SCRIPT_DIR="$(realpath "$(dirname "$0")")"
CUSTOM_DIR="$SCRIPT_DIR/home-manager/custom"
CUSTOM_FILES=(
	"custom-hyprland.nix"
)


############################################
#  				Functions				   #
############################################
has_nvidia() {
	# Check if nvidia GPU is present
	echo "Checking for Nvidia GPU"
	if ls /dev | grep -q 'nvidia[0-9]\+'; then
		echo "Nvidia GPU detected - Enabling Nvidia Drivers & Settings"
		return 0
	else
		echo "No Nvidia GPU detected - Disabling Nvidia Drivers & Settings"
		if ! sed -n '5p' $SCRIPT_DIR/nixos/configuration.nix | grep -q '^#'; then
            sed -i '5s/^/#/' $SCRIPT_DIR/nixos/configuration.nix
        fi
		return 1
	fi
}

log() {
	local timestamp=$(date +"%Y-%m-%d %T")
    if [[ $1 != "-m" ]]; then
        echo "$@"
		echo "[$timestamp] $@" >> $SCRIPT_DIR/rebuild.log
	else
		shift
		echo "[$timestamp] $@" >> $SCRIPT_DIR/rebuild.log
    fi
}

help_text() {
	ascii_title
    local term_width="$(tput cols)"
    local hpad=2
    local box_width=$((term_width - 2*hpad))
    local line
    local content=(
        "Usage:"
        "  -h -- Shows this menu"
		"  -i -- Fresh install of NixOS (WIP)"
		"  -u -- Updates the system configuration and home-manager configuration"
        "  -m [MODE_CHOICE] -- Rebuilds system configuration or home-manager configuration"
        "     Valid MODE_CHOICE Options:"
        "      home -- Switch to the current home-manager configuration in ~/nix/home-manager/home.nix"
        "      nix -- Switch to the current nixOS configuration in ~/nix/flake.nix"
    )
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
    for line in "${content[@]}"; do
        printf "| %-${box_width}s |\n" "$(echo "$line" | fold -s -w $((box_width - 2)))"
    done
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
}

ascii_title() {
	local line
    local content=(
       " _______  .__       ________    _________               "
        " \      \ |__|__  __\_____  \  /   _____/               "
        " /   |   \|  \  \/  //   |   \ \_____  \                "
        "/    |    \  |>    </    |    \/        \               "
        "\____|__  /__/__/\_ \_______  /_______  /               "
        "        \/         \/       \/        \/                "
        ".___                 __         .__  .__                "
        "|   | ____   _______/  |______  |  | |  |   ___________ "
        "|   |/    \ /  ___/\   __\__  \ |  | |  | _/ __ \_  __ \\"
        "|   |   |  \\___ \  |  |  / __ \|  |_|  |_\  ___/|  | \/"
        "|___|___|  /____  > |__| (____  /____/____/\___  >__|   "
        "         \/     \/            \/               \/       "
    )
	for i in "${!content[@]}"; do
		line=${content[$i]}
		if (( i < 6 )); then
			echo -e "\033[0;35m$line\033[0m"
		else
			echo "$line"
		fi
    done
}

rebuild_option() {
	case "$1" in
	"home") home-manager --flake $SCRIPT_DIR switch ;;
	"nix") nixos-rebuild --flake $SCRIPT_DIR switch --impure ;;
	"full") nixos-rebuild --flake $SCRIPT_DIR switch --impure && home-manager --flake $SCRIPT_DIR switch ;;
	*) echo "ERROR: Only valid modes are ['home', 'nix', 'full']." && echo "Invalid Mode: '$1'" ;;
	esac
	return 0
}

fresh_install() {
	# Remove the log file if it exists
	rm -f $SCRIPT_DIR/rebuild.log
	# Log the start of the fresh install
	log -m "Fresh Install Began"
	local user_name
	local host_name
	local home_man_dir="$SCRIPT_DIR/home-manager/"
	# Check to see if there is an nvidia GPU
	has_nvidia
	# Prompt for user input
	read -p "Enter your username: " user_name
	read -p "Enter your hostname: " host_name
	echo "\n\n== User Information =="
	log "Username: $user_name"
	log "Hostname: $host_name"
	# Set the username and hostname in the flake.nix file
	sed -i "s/<TEMP_USERNAME>/$user_name/g" $SCRIPT_DIR/flake.nix
	sed -i "s/<TEMP_HOSTNAME>/$host_name/g" $SCRIPT_DIR/flake.nix
	# Check if the user wants to use custom configurations
	echo "\n\n== Custom Configurations =="
	echo -e "Custom configurations are located in \n '\033[0;32m$CUSTOM_DIR\033[0m'"
	for file in "${CUSTOM_FILES[@]}"; do
		local custom_config
		local program=$(echo $file | cut -d'-' -f2 | cut -d'.' -f1)
		read -p "Would you like to use custom configurations for $program? [y/N]: " custom_config
		if [[ -z "$custom_config" ]]; then
			custom_config="N"
		fi
		log -m "Custom Configurations for $program: $custom_config"
		if [[ "$custom_config" == "Y" || "$custom_config" == "y" ]]; then
			local nix_file="$SCRIPT_DIR/nixos/$program.nix"
			echo "Using custom configuration for $program"
			# Change the nix file to use the custom configuration
		fi
	done
}

testing() {
	fresh_install
}

clear_config() {
	sed -i "s/\"eef\"/\"<TEMP_USERNAME>\"/g" $SCRIPT_DIR/flake.nix
	sed -i "s/\"nixos\"/\"<TEMP_HOSTNAME>\"/g" $SCRIPT_DIR/flake.nix
}


############################################
#  				   Main 				   #
############################################
# If no arguments, then show help text
if [[ "$#" -eq 0 ]]; then
	help_text
fi
while test $# != 0; do
	case "$1" in
	install) fresh_install ;;
	-i) fresh_install ;;

	help) help_text ;;
	-h) help_text ;;

	mode) rebuild_option $2 ;;
	-m) rebuild_option $2 ;;

	update) rebuild-option "full" ;;
	-u) rebuild-option "full" ;;

	test) testing ;;
	-t) testing ;;

	undo) clear_config ;;
	-ut) clear_config ;;
	esac
	shift
done
