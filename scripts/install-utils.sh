#!/bin/sh

# a collection of install scripts to download utils for the software I use

# zsh
export ZSH="$HOME/.config/oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" # oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM/plugins/zsh-autosuggestions" # zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" # zsh-syntax-highlightning

# dracula theme for zsh
wget https://github.com/dracula/zsh/archive/master.zip
unzip -j master.zip "zsh-master/dracula.zsh-theme" "zsh-master/lib/*"
mv dracula.zsh-theme "$XDG_CONFIG_HOME/oh-my-zsh/themes"
mv async.zsh "$XDG_CONFIG_HOME/oh-my-zsh/lib"
rm master.zip

# tmux
git clone https://github.com/tmux-plugins/tpm "$HOME/.config/tmux/plugins/tpm"

exec zsh # source zsh config for the plugins to register
