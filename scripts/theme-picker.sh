#!/bin/sh

: "${XDG_CONFIG_HOME:=$HOME/.config}"

if ! which "fzf" > /dev/null; then
  echo "Missing fzf installation, exiting."
  exit 1
fi

pick_and_link() {
  theme_dir="$1"
  symlink_path="$2"
  find_type="$3"
  prompt="$4"

  selected_theme=$(find "$theme_dir" -type "$find_type" | fzf --header="$prompt")

  if [ -n "$selected_theme" ]; then
    ln -sf "$selected_theme" "$symlink_path"
    echo "Linked to $symlink_path"
  fi
}

pick_and_link \
  "$XDG_CONFIG_HOME/kitty/themes" \
  "$XDG_CONFIG_HOME/kitty/theme.conf" \
  "f" \
  "Choose theme for kitty"

pick_and_link \
  "$XDG_CONFIG_HOME/tmux/themes" \
  "$XDG_CONFIG_HOME/tmux/theme.conf" \
  "f" \
  "Choose theme for tmux"

pick_and_link \
  "$XDG_CONFIG_HOME/nvim/lua/custom/themes" \
  "$XDG_CONFIG_HOME/nvim/lua/custom/plugins/theme.lua" \
  "f" \
  "Choose theme for nvim"

pick_and_link \
  "$XDG_CONFIG_HOME/spicetify/Themes" \
  "$XDG_CONFIG_HOME/spicetify/Themes/Theme" \
  "d" \
  "Choose theme for spicetify"
