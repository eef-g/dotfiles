#!/bin/bash

# Globals
DIRECTORY=$DOTFILES_DIR/bin/nvidia-all
RED='\033[0;31m'
NC='\033[0m'

# Functions
scriptCheck() {
  if [ ! -d $DIRECTORY ]; then
    printf "${RED}ERROR: NVIDIA-ALL not detected"
    printf "${NC} Cloning NVIDIA-ALL Repository to dotfiles..."
    git clone https://github.com/Frogging-Family/nvidia-all.git $DOTFILES_DIR/bin/nvidia-all
  fi
}

runScript() {
  scriptCheck
  cd $DIRECTORY
  makepkg -si
}

updateScript() {
  scriptCheck
  cd $DIRECTORY
  git pull
}

Help() {
  printf '${NC}'
  echo "#--------------------------------------------#"
  echo "|         Ethan's Nvidia-All Manager         |"
  echo "|--------------------------------------------|"
  echo "|              Available flags:              |"
  echo "|                [-h|-u|-r]                  |"
  echo "|--------------------------------------------|"
  echo "| -h         | Shows this menu               |"
  echo "| -u         | Updates the Nvidia-all script |"
  echo "| <NONE>, -r | Runs the nvidia-all script    |"
  echo "#--------------------------------------------#"
}

# Flags
while getopts "hur" flag; do
  case $flag in
  h) # Help function
    Help
    ;;
  u) # Update function
    echo "Updating NVIDIA-ALL"
    updateScript
    ;;
  r) # Run the script
    echo "Running NVIDIA-ALL"
    runScript
    ;;
  \?) # Invalid option
    echo "Error: Invalid option"
    ;;
  esac
done

# If there are no flags
runScript
