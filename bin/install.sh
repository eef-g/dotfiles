#!/bin/bash
PKGS=("stow" "fastfetch" "lazygit" "neovim"
	"tmux" "foot" "zsh" "gcc" "rubygems"
	"ruby-devel" "lazygit" "inotify-tools")

echo "Installing dependencies"
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

pkg_install() {

	local distro
	local cmd
	local usesudo
	declare -A pkgmgr
	pkgmgr=(
		[alpine]="apk add --no-cache"
		[debian]="apt-get install -y"
		[ubuntu]="apt-get install -y"
		[fedora]="dnf install -y"
	)

	distro=$(cat /etc/os-release | tr [:upper:] [:lower:] | grep -Poi '(debian|ubuntu|red hat|centos|alpine|fedora)' | uniq)
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

DIST=$(cat /etc/os-release | tr [:upper:] [:lower:] | grep -Poi '(debian|ubuntu|red hat|centos|arch|alpine|fedora)' | uniq)

if [[ $DIST != "arch" ]]; then
	echo "Not Arch-Based"
	for PKG in ${PKGS[@]}; do
		pkg_install $PKG
	done
else
	echo "Arch-Based"
	sudo pacman -S --needed - <$SCRIPT_DIR/backups/pkglist.bak
	sudo cp $SCRIPT_DIR/backups/pacman-hook.bak /usr/share/libalpm/hooks/pkglist.hook
fi

# Adding the pwd to the env variable
echo "Adding pwd as an env variable: DOTFILES_DIR"
export DOTFILES_DIR=$(pwd)
echo "export DOTFILES_DIR=$(pwd)" >/tmp/tmpzsh && cat $(pwd)/.zshrc >>/tmp/tmpzsh && mv /tmp/tmpzsh $(pwd)/.zshrc

echo "Installing tpm"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "Please run sync script with 'bin/sync.sh' or 'sync.sh' depending on your pwd."
