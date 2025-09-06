alias rmf="rm -rf"
alias md="mkdir -p"
function mkcd() {
  mkdir -p "$1" && cd "$1" || return
}
alias c="clear"
alias vi="nvim"
alias conf="vi ~/.config"
alias viconf="vi ~/.config/nvim/lua/plugins"
