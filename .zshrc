export DOTFILES_DIR=/home/eef/dotfiles
# If you come from bash you might have to change your $PATH.
#
#
export PATH=$HOME/bin:/usr/local/bin:$HOME/.cargo/bin:$HOME/.local/share/bob/nvim-bin:/home/eef/.local/share/gem/ruby/3.0.0/bin:/home/eef/.local/share/gem/ruby/3.1.0/bin:/usr/lib/jvm:/home/eef/.spicetify:$PATH


if [[ ! -f ~/.zpm/zpm.zsh ]]; then
  git clone --recursive https://github.com/zpm-zsh/zpm ~/.zpm
fi

source ~/.zpm/zpm.zsh
# Install plugins here ONLY if zpm is installed
if [[ -f ~/.zpm/zpm.zsh ]]; then
  zpm load zsh-users/zsh-autosuggestions
  zpm load zsh-users/zsh-syntax-highlighting
fi


# Aliases
alias syncdots="$DOTFILES_DIR/bin/sync.sh"
if [ -x "$(command -v colorls)" ]; then
    alias ls="colorls"
    alias la="colorls -al"
fi
alias ffetch="clear && fastfetch --raw $HOME/.config/fastfetch/eef.sixel --logo-width 25 --logo-height 15"
alias vencord-installer="$DOTFILES_DIR/bin/vencord.sh"

# Enable zoxide
eval "$(zoxide init zsh)"


# Enable starship prompt
eval "$(starship init zsh)"
