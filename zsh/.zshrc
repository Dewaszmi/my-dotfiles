export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
  git
  dnf
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

eval "$(zoxide init zsh)"

export PATH=$PATH:/home/dewaszmi/.local/bin
export ZSH_COMPDUMP="$HOME/.cache/zcompdump/.zcompdump"
export EDITOR="nvim"

export PATH=$PATH:/home/dewaszmi/.spicetify

# Pyenv
# export PYENV_ROOT="$HOME/.pyenv"
# [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init - bash)"


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

# Zoxide so i wont forget
alias cd="z"

alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

# Apps
alias vi="nvim"
alias y="yazi"
alias t="tmux"
alias ff="fastfetch"
alias cj="carjacker"

# Software
alias sv="source .venv/bin/activate"

# Git aliases
alias lg="lazygit"
