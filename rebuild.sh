#!/usr/bin/env bash

############################################
#  				Global Vars				   #
############################################
SCRIPT_DIR="$(realpath "$(dirname "$0")")"
CUSTOM_DIR="$SCRIPT_DIR/home-manager/custom"
CUSTOM_FILES=(
	"custom-hyprland.nix"
	"custom-zsh.nix"
)


############################################
#  				Functions				   #
############################################
has_nvidia() {
	# Check if nvidia GPU is present
	log "Checking for Nvidia GPU"
	if ls /dev | grep -q 'nvidia[0-9]\+'; then
		log "Nvidia GPU detected - Enabling Nvidia Drivers & Settings"
		return 0
	else
		log "No Nvidia GPU detected - Disabling Nvidia Drivers & Settings"
		if ! sed -n '5p' $SCRIPT_DIR/nixos/configuration.nix | grep -q '^#'; then
            sed -i '5s/^/#/' $SCRIPT_DIR/nixos/configuration.nix
			log -m "Commented out line 5 in $SCRIPT_DIR/nixos/configuration.nix -- Uncomment to enable Nvidia Drivers & Settings"
        fi
		return 1
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
	log -m "Rebuild Option: $1"
	case "$1" in
	"home")  
		home-manager --flake $SCRIPT_DIR switch
	;;
	"nix") 
		nixos-rebuild --flake $SCRIPT_DIR switch --impure
	;;
	"full") 
		nixos-rebuild --flake $SCRIPT_DIR switch --impure
		home-manager --flake $SCRIPT_DIR switch
	;;
	*)
		echo "ERROR: Only valid modes are ['home', 'nix', 'full']." 
		echo "Invalid Mode: '$1'"
	;;
	esac
	log -m "Rebuild Option: $1 -- Completed"
	return 0
}

fresh_install() {
	# Remove the log file if it exists
	rm -f $SCRIPT_DIR/rebuild.log
	# Log the start of the fresh install
	log -m "Fresh Install Began"
	local user_name
	local host_name
	local enable_custom_configs
	# Check to see if there is an nvidia GPU
	has_nvidia
	# Prompt for user input
	log -m "Prompting for name & devicename"
	read -p "Enter your username: " user_name
	read -p "Enter your hostname: " host_name
	echo ""
	echo ""
	echo "== User Information =="
	log "Username: $user_name"
	log "Hostname: $host_name"
	# Set the username and hostname in the flake.nix file
	sed -i "s/<TEMP_USERNAME>/$user_name/g" $SCRIPT_DIR/flake.nix
	sed -i "s/<TEMP_HOSTNAME>/$host_name/g" $SCRIPT_DIR/flake.nix
	# Check if the user wants to use custom configurations
	echo ""
	echo ""
	echo "== Custom Configurations =="
	echo -e "Custom configurations are located in \n '\033[0;32m$CUSTOM_DIR\033[0m'"
	read -p "Would you like to use custom configurations? [y/N]: " enable_custom_configs
	if [[ -z "$enable_custom_configs" ]]; then
		enable_custom_configs="N"
		log -m "Using default configurations"
	fi
	if [[ "$enable_custom_configs" == "Y" || "$enable_custom_configs" == "y" ]]; then
		# Use custom configurations
		use_custom_configs
	fi
	# Run the nixos-rebuild command to install the system
	rebuild_option "full"
	# Log the end of the fresh install
	log -m "Fresh Install Completed"
}

use_custom_configs() {
	log -m "Using custom configurations"
	# Use custom configurations for the specified programs
	for file in "${CUSTOM_FILES[@]}"; do
		local custom_config
		local program=$(echo $file | cut -d'-' -f2 | cut -d'.' -f1)
		read -p $'Would you like to use custom configurations for \033[0;32m'"$program"$'\033[0m? [y/N]: ' custom_config
		if [[ -z "$custom_config" ]]; then
			custom_config="N"
		fi
		if [[ "$custom_config" == "Y" || "$custom_config" == "y" ]]; then
			local nix_file="$SCRIPT_DIR/nixos/$program.nix"
			echo "Using custom configuration for $program"
			# Change the nix file to use the custom configuration
			local line_num=$(grep -n "programs.$program = import" $SCRIPT_DIR/home-manager/home.nix | cut -d':' -f1)
			line_num=$((line_num + 2)) # Need to add 2 to get to the actual line since the import line is 2 lines above the actual line
			sed -i "${line_num}s/false/true/" $SCRIPT_DIR/home-manager/home.nix
			log -m "Changed value of line $line_num in $SCRIPT_DIR/home-manager/home.nix to true for $program"
		fi
	done
	log -m "Change use-custom values in $SCRIPT_DIR/home-manager/home.nix to false to disable custom configurations"
	log -m "Custom configurations have been set"
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

testing() {
	fresh_install
}

clear_config() {
	# Reset the flake.nix file to the original state from the test values
	sed -i "s/\"eef\"/\"<TEMP_USERNAME>\"/g" $SCRIPT_DIR/flake.nix
	sed -i "s/\"nixos\"/\"<TEMP_HOSTNAME>\"/g" $SCRIPT_DIR/flake.nix
	# Reset the home-manager configuration to not use custom configurations
	sed -i "s/use-custom = true/use-custom = false/g" $SCRIPT_DIR/home-manager/home.nix
	# Reset the nixos configuration to not have NVIDIA commented out if it is
	if sed -n '5p' $SCRIPT_DIR/nixos/configuration.nix | grep -q '^#'; then
		sed -i '5s/^#//' $SCRIPT_DIR/nixos/configuration.nix
	fi
	echo "Configuration has been reset to default -- You can push the changes if needed"
}



############################################
#  				   Main 				   #
############################################
# If no arguments, then show help text
if [[ "$#" -eq 0 ]]; then
	help_text
fi
# Parse arguments
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
