export PATH="$PATH:/home/dewaszmi/.local/bin"
export ZSH_COMPDUMP="$HOME/.cache/zcompdump/.zcompdump"
export EDITOR="nvim"

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

# Disable Ctrl-s flow control (to free it for nvim)
stty -ixon

# Run sway on terminal startup
if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    exec sway
fi

eval "$(starship init zsh)"

source $HOME/.config/zsh/scripts/tmux-autovenv.zsh

export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

export VDPAU_DRIVER="va_gl" # for vlc
# export WINEDLLOVERRIDES="version=n,b" # for wine (MelonLoader for pvz fusion)
