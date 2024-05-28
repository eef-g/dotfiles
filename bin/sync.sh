#!/bin/bash

# This script will be fleshed out eventually, but for now serves no purpose
echo "Syncing dotfiles"

cd ~/dotfiles && stow . --adopt

# Update the zsh configs
source ~/.zshrc

# Source the tmux config
tmux source ~/.tmux.conf
