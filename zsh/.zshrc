# Path to your Oh My Zsh installation.
export ZSH="$HOME/.config/oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
  git
  zsh-autosuggestions
  copyfile
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Run sway on terminal startup
if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    exec sway
fi

eval "$(starship init zsh)"
