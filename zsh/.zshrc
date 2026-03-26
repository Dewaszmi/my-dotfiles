# env variables
export ZSH_COMPDUMP="$HOME/.cache/zcompdump/.zcompdump"
export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR="nvim"

# oh-my-zsh config
export ZSH="$XDG_CONFIG_HOME/oh-my-zsh"

# theme
ZSH_THEME="dracula" # "robbyrussell"

# oh-my-zsh plugins
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# some path extensions
export PATH=$PATH:/home/dewaszmi/.local/bin
export PATH=$PATH:/home/dewaszmi/.spicetify
export PATH=$PATH:/home/dewaszmi/.cargo/bin

eval "$(zoxide init zsh)"

# ===========================
# aliases
alias c="clear"
alias rmf="rm -rf"
alias md="mkdir -p"
alias o="xdg-open"

mkcd () {
  mkdir -p "$1"
  cd "$1"
}

# zoxide so I wont forget
alias cd="z"

# better ls
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

alias vi="nvim"
alias y="yazi"
alias ff="fastfetch"

# tmux
alias t="tmux"
alias tn="tmux new-session -s"
alias ta="tmux attach"
alias td="tmux detach"
alias tl="tmux list-sessions"
alias tk="tmux kill-session -t"

# other
alias sv="source .venv/bin/activate"
alias kps="sh ~/stuff/keepass-tui/interactive-cli.sh $KEEPASS_DATABASE_PATH"
alias zconf="vi $HOME/.zshrc"
alias viconf="vi $XDG_CONFIG_HOME/nvim"

# git aliases
alias lg="lazygit"
