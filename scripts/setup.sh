#!/bin/bash

# This script will be fleshed out eventually, but for now serves no purpose
echo "Syncing dotfiles"

cd ~/dotfiles &
stow . --adopt

# Update the omz & zsh configs
zsh && exit
# Source the tmux config
tmux source ~/.tmux.conf
