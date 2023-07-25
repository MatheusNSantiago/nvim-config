#!/usr/bin/sh
# TODO: Tentar fazer algo parecido com esse script: https://github.com/Nguyen-Hoang-Nam/nvim-dotfiles-kitty/blob/main/install.sh

NVIM_CONFIG=~/.config/nvim
NVIM_PLUGINS=~/.local/share/nvim

rm -rf $NVIM_CONFIG
rm -rf $NVIM_PLUGINS

mkdir -p $NVIM_PLUGINS
mkdir -p $NVIM_CONFIG

cp -r . $NVIM_CONFIG
