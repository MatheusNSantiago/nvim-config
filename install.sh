#!/usr/bin/sh

NVIM_CONFIG=~/.config/nvim
NVIM_PLUGINS=~/.local/share/nvim

rm -rf $NVIM_CONFIG
rm -rf $NVIM_PLUGINS

mkdir -p $NVIM_PLUGINS
mkdir -p $NVIM_CONFIG

cp -r . $NVIM_CONFIG
