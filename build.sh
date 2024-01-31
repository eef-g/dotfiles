#!/usr/bin/env bash

# Set the default image name
image="default"

# Check if a command line argument was provided
if [ "$#" -gt 0 ]; then
    case "$1" in
        -h|--help)
            echo "Usage: $0 [image]"
            echo "Description:"
            echo "Build the specified NixOS image. If no image is specified, the default image is built."
            echo "NOTE: If the script does not work, try running it with sudo."
            echo ""
            echo "Available images:"
            find ./hosts -mindepth 1 -maxdepth 1 -type d -exec bash -c 'printf "    %s\n" "$(basename "$0")"' {} \;
            echo""
            echo " To make a new image:"
            echo "  1. Create a new directory in ./hosts"
            echo "  2. Create a configuration.nix file in the new directory"
            echo "  3. Add the new directory to the outputs of ./flake.nix"
            echo "  4. Run $0 [new directory name]"
            exit 0
            ;;
        *)
            image="$1"
            ;;
    esac
fi

# Run the nixos-rebuild command with the image name
nixos-rebuild switch --flake .#${image}