# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$HOME/.cargo/bin:$HOME/.local/share/bob/nvim-bin:/home/eef/.local/share/gem/ruby/3.1.0/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

zstyle ':omz:update' mode reminder  # just remind me to update when it's time
DISABLE_AUTO_TITLE="true"
ZSH_CUSTOM=$HOME/.config/.oh-my-zsh

plugins=( git zsh-syntax-highlighting zsh-autosuggestions )

source $ZSH/oh-my-zsh.sh

# User configuration
# Aliases
alias syncdots="./dotfiles/scripts/setup.sh"
if [ -x "$(command -v colorls)" ]; then
    alias ls="colorls"
    alias la="colorls -al"
fi

# Enable starship prompt
eval "$(starship init zsh)"
