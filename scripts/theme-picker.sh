#!/bin/sh

: "${XDG_CONFIG_HOME:=$HOME/.config}"

if ! which "fzf" > /dev/null; then
  echo "Missing fzf installation, exiting."
  exit 1
fi

pick_and_link() {
  theme_dir="$1"
  symlink_path="$2"
  prompt="$3"

  selected_theme=$(find "$theme_dir" -type f | fzf --header="$prompt")

  if [ -n "$selected_theme" ]; then
    ln -sf "$selected_theme" "$symlink_path"
    echo "Linked to $symlink_path"
  fi
}

pick_and_link \
  "$XDG_CONFIG_HOME/kitty/themes" \
  "$XDG_CONFIG_HOME/kitty/theme.conf" \
  "Choose theme for kitty"

pick_and_link \
  "$XDG_CONFIG_HOME/tmux/themes" \
  "$XDG_CONFIG_HOME/tmux/theme.conf" \
  "Choose theme for tmux"

pick_and_link \
  "$XDG_CONFIG_HOME/nvim/lua/custom/themes" \
  "$XDG_CONFIG_HOME/nvim/lua/custom/plugins/theme.lua" \
  "Choose theme for nvim"
