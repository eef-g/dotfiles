#!/bin/bash

sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"
echo "Updating Discord wayland fix..."
sudo cp $DOTFILES_DIR/bin/backups/discord.desktop.bak ~/.local/share/applications/discord.desktop
