#!/bin/bash

# This is a script that is only made and needs to be run whenever the Wayland session is no longer functioning
# (Thank you Nvidia, very cool!)
#

echo "Swapping /etc/environment file out for backup in dotfiles"
sudo cp $DOTFILES_DIR/bin/backups/environment.bak /tmp/env.bak
sudo cp /etc/environment $DOTFILES_DIR/bin/backups/environment.bak
sudo cp /tmp/env.bak /etc/environment
echo "File /etc/environment changed to:"
cat /etc/environment
echo ""
echo "Swap complete, please reboot to finish changes."
