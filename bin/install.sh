#!/bin/bash
PKGS=("stow" "fastfetch" "lazygit" "neovim"
	  "tmux" "foot" "zsh" "gcc" "rubygems"
	  "ruby-devel")

echo "Installing dependencies"

pkg_install() {

	local distro
	local cmd
	local usesudo
	declare -A pkgmgr
	pkgmgr=(
		[arch]="pacman -S --noconfirm"
		[alpine]="apk add --no-cache"
		[debian]="apt-get install -y"
		[ubuntu]="apt-get install -y"
		[fedora]="dnf install -y"
	)

	distro=$(cat /etc/os-release | tr [:upper:] [:lower:] | grep -Poi '(debian|ubuntu|red hat|centos|arch|alpine|fedora)' | uniq)
	cmd="${pkgmgr[$distro]}"
	[[ ! $cmd ]] && return 1
	if [[ $1 ]]; then
		[[ ! $EUID -eq 0 ]] && usesudo=sudo
		echo installing packages command: $usesudo $cmd $@
		$usesudo $cmd $@
	else
		echo $cmd
	fi
}

# This will be a loop to go through all of the needed dependencies
for PKG in ${PKGS[@]}; do
	pkg_install $PKG
done

# Adding the pwd to the env variable
echo "Adding pwd as an env variable: DOTFILES_DIR"
export DOTFILES_DIR=$(pwd)
echo "export DOTFILES_DIR=$(pwd)" > /tmp/tmpzsh && cat $(pwd)/.zshrc >> /tmp/tmpzsh && mv /tmp/tmpzsh $(pwd)/.zshrc

echo "Changing shell to zsh"
chsh -s $(which zsh)

echo "Syncing dotfiles"
cd ~/dotfiles && stow . --adopt