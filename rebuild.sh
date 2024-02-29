#!/usr/bin/env bash

# Functions
help_text() {
	echo "=-=-=- Eef's NixOS Rebuild Script -=-=-="
	echo "Usage:"
	echo "  -h -- Shows this menu"
	echo "  -m [MODE_CHOICE] -- Rebuilds system configuration or home-manager configuration"
	echo "     Valid MODE_CHOICE Options:"
	echo "      home -- Switch to the current home-manager configuration in ~/nix/home-manager/home.nix"
	echo "      nix -- Switch to the current nixOS configuration in ~/nix/flake.nix"
	echo "Notes:"
	echo "  * Run the script with no arguments to rebuild both the home-manager and nixOS configurations at once!"
	echo "  * If you want to rebuild nixOS, please run the script with the sudo argument"
	return 0
}

rebuild_option() {
	case "$1" in
	"home") home-manager --flake /home/eef/nix switch ;;
	"nix") nixos-rebuild --flake /home/eef/nix switch --impure ;;
	"full") nixos-rebuild --flake /home/eef/nix switch --impure && home-manager --flake /home/eef/nix switch ;;
	*) echo "ERROR: Only valid modes are ['home', 'nix', 'full']." && echo "Invalid Mode: '$1'" ;;
	esac
	return 0
}

# If no arguments, then do full rebuild
if [[ "$#" -eq 0 ]]; then
	echo "Rebuilding nixOS & Home Manager"
	rebuild_option "full"
fi

# Flag handling
while test $# != 0; do
	case "$1" in
	-h) help_text ;;
	-m) rebuild_option $2 ;;
	esac
	shift
done
