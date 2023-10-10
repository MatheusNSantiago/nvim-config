#!/usr/bin/sh

INSTALL_FOLDER="$HOME/.local/share/nvim/language-servers"

makedir -p "$INSTALL_FOLDER"
rm -rf "$INSTALL_FOLDER/lua-language-server"
git clone https://github.com/LuaLS/lua-language-server "$INSTALL_FOLDER/lua-language-server"

cd "$INSTALL_FOLDER/lua-language-server" && ./make.sh
