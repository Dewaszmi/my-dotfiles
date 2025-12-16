# Run sway on terminal startup
# if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
#     exec sway
# fi

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.config/zsh/oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
  git
  zsh-autosuggestions
  copyfile
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

export PATH=$PATH:/home/dewaszmi/.spicetify
export PATH=$PATH:/home/dewaszmi/.local/bin

source /usr/share/nvm/init-nvm.sh

# export XDG_CURRENT_DESKTOP=sway
export ZSH_COMPDUMP="$HOME/.cache/zcompdump/.zcompdump"
export EDITOR="nvim"
export ZDOTDIR="$HOME/.config/zsh"
# export GSK_RENDERER=gl nautilus # for nautilus warnings to shut up

# ===============
# === ALIASES ===
# ===============

# Generic aliases
alias c="clear"
alias rmf="rm -rf"
alias md="mkdir -p"
alias o="xdg-open"

mkcd () {
  mkdir -p "$1"
  cd "$1"
}

# Apps
alias vi="nvim"
alias y="yazi"
alias ff="fastfetch"
alias wifi="nmtui"
alias bt="bluetui"

# Software
alias py="python"
alias sv="source .venv/bin/activate"

# Git aliases
alias gc="git clone"
alias gac="git add . & git commit -m"
alias lg="lazygit"


# Zoxide so i wont forget
alias cd="z"

# Package management
alias yays="yay -S"
alias yayq="yay -Qs"
alias yayr="yay -Rns"

alias fm="nautilus . &"
