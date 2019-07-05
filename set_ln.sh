#!/bin/bash
#
# Asins <asinsimple@gmail.com>

cd $(dirname $BASH_SOURCE)
BASE=$(pwd)

# 清歌输入法字库
ln -sfv $BASE/.config/qingg.im  ~/.config/qingg.im

# Git
#rm -f ~/.gitconfig ~/.gitignore
ln -sfv $BASE/.gitconfig ~/.gitconfig
ln -sfv $BASE/.gitignore ~/.gitignore

# fish 配置
ln -sfv $BASE/.config/fish/aliases.fish ~/.config/fish/aliases.fish
ln -sfv $BASE/.config/fish/config.fish ~/.config/fish/config.fish
ln -sfv $BASE/.config/fish/env.fish ~/.config/fish/env.fish

# fish 函数
mv ~/.config/fish/functions ~/.config/fish/functions_bck
ln -sfv $BASE/.config/fish/functions ~/.config/fish/functions
mv -r ~/.config/fish/functions_bck/* ~/.config/fish/functions/
rm -rf ~/.config/fish/functions_bck
