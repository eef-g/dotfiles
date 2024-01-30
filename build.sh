#!/run/current-system/sw/bin/bash

# Set the default image name
image="default"

# Check if a command line argument was provided
if [ "$#" -gt 0 ]; then
    image="$1"
fi

# Run the nixos-rebuild command with the image name
nixos-rebuild switch --flake /home/eef/nix#${image}