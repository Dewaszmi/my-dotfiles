# -----------------------------
# Auto-source python venvs in new tmux panes only
# -----------------------------

# Export current venv to tmux environment
function tmux_venv_export() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    tmux set-environment -g TMUX_VIRTUAL_ENV "$VIRTUAL_ENV"
  else
    tmux set-environment -g -u TMUX_VIRTUAL_ENV
  fi
}

# Import venv from tmux environment
function tmux_venv_import() {
  local venv_path
  venv_path=$(tmux show-environment -g TMUX_VIRTUAL_ENV 2>/dev/null | cut -d= -f2-)
  if [[ -n "$venv_path" && -f "$venv_path/bin/activate" ]]; then
    source "$venv_path/bin/activate"
  fi
}

# -----------------------------
# Hooks to export venv
# -----------------------------
autoload -Uz add-zsh-hook
add-zsh-hook chpwd tmux_venv_export

function venv_auto_export_precmd() {
  tmux_venv_export
}
add-zsh-hook precmd venv_auto_export_precmd

# -----------------------------
# Auto-import venv only in new panes
# -----------------------------
if [[ -n "$TMUX" && -z "$TMUX_VENV_IMPORTED" ]]; then
  # Determine the first pane in this window
  FIRST_PANE=$(tmux list-panes -F '#{pane_id}' -t "$TMUX_PANE" | head -n1)

  # Only import if this is NOT the first pane (i.e., a split pane)
  if [[ "$TMUX_PANE" != "$FIRST_PANE" ]]; then
    tmux_venv_import
  fi

  # Mark this shell as already imported to avoid re-sourcing
  export TMUX_VENV_IMPORTED=1
fi

