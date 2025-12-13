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
