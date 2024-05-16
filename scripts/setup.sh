#!/bin/bash

# This script will be fleshed out eventually, but for now serves no purpose
echo "Syncing dotfiles"

cd ~/dotfiles &
stow . --adopt
