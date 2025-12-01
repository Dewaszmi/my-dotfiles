# Run sway on terminal startup
if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    exec sway
fi

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

source $HOME/.config/zsh/scripts/tmux-autovenv.zsh

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
