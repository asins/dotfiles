#!/bin/bash
# Asins <asinsimple@gmail.com>

realpath() {
  path=`eval echo "$1"`
  folder=$(dirname "$path")
  echo $(cd "$folder"; pwd)/$(basename "$path");
}

#RC files
cd $(dirname $BASH_SOURCE)
BASE_PATH=$(pwd)

#nginx log目录
sudo mkdir -pv "/var/log/nginx"

# 待复制的文件或目录
copyPathArray=(
  #.ssh/config文件中有隐私内容所以就不做链接了以免不小心上传到github上，公司安全部的茶不好喝
  ".ssh/config: ~/.ssh/config"
)

lnPathArray=(

  # 默认的Bash
  ".bash_profile: ~/.bash_profile"
  ".bashrc: ~/.bashrc"
  "bin: ~/.bin"

  # Git
  ".gitconfig: ~/.gitconfig"

  # 清歌输入法字库
  "qingg.im: ~/.config/qingg.im"

  # Vim
  ".config/vim/init.vim: ~/.vimrc"
  ".config/vim: ~/.vim"

  # alacritty终端应用
  ".config/alacritty: ~/.config/alacritty"
  ".config/neofetch: ~/.config/neofetch"

  # Nginx配置
  "nginx/nginx.conf: /usr/local/etc/nginx/nginx.conf"
  "nginx/conf.d: /usr/local/etc/nginx/conf.d"
  "create_ssl: /usr/local/etc/nginx/ssl"

  # nvim
  #ln -sfv $BASE/.config/nvim ~/.vim
  #ln -sfv $BASE/.config/nvim/init.vim ~/.config/nvim/init.vim

  # zsh
  #ln -sfv $BASE/.config/zsh/.zshrc ~/.zshrc
  ".config/zsh/.zshrc: ~/.zshrc"

  # vscode 键盘映射
  # "vscode/keybindings.json: ~/Library/Application Support/Code/User/keybindings.json"

  # Fish 配置
  ".config/fish/aliases.fish: ~/.config/fish/aliases.fish"
  ".config/fish/config.fish: ~/.config/fish/config.fish"
  ".config/fish/env.fish: ~/.config/fish/env.fish"
  ".config/fish/functions: ~/.config/fish/functions"
)

function lnFiles() {
  mkdir -pv $BASE_PATH/bak
  for key in ${!lnPathArray[@]}; do
    VALUE=${lnPathArray[$key]}
    origin=${VALUE%%: *}
    target=$(realpath "${VALUE#*: }")
    # echo "lnFiles: ${origin} => ${target}"

    mkdir -pv $(dirname "${target}")
    if [ -L "${target}" ]; then # 存在的是软链接
      printf '[\e[0;33mremove old ln\e[0m] '
      rm -r "${target}"
    elif [ -f "${target}" ]; then # 真实文件存在
      printf '[\e[0;33mln back\e[0m] %s\n' "$(mv -v "${target}" $BASE_PATH/bak/$(basename "${target}"))"
      printf '[\e[0;33mln back\e[0m] %s\n' "$(ln -sfv "${BASE_PATH}/${origin}" "${target}")"
      return
      # TODO: 创建的备份文件需确保目录在bak下对应URI目录存在
      # mv -v "${target}" $BASE_PATH/bak/$(basename "${target}")
    elif [ -d "${target}" ]; then # 真实目录存在
      printf '[\e[0;33mln back\e[0m] %s\n' "$(mv -v "${target}" $BASE_PATH/bak/$(basename "${target}"))"
      printf '[\e[0;33mln back\e[0m] %s\n' "$(ln -sfv "${BASE_PATH}/${origin}" "${target}")"
      return
      # TODO: 创建的备份文件需确保目录在bak下对应URI目录存在
      # mv -v "${target}" $BASE_PATH/bak/$(basename "${target}")
    fi
    printf '[\e[0;32mln -sfv\e[0m] '
    ln -sfv "${BASE_PATH}/${origin}" "${target}"
  done
}

function copyFiles() {
  for key in ${!copyPathArray[@]}; do
    VALUE=${copyPathArray[$key]}
    origin=${VALUE%%: *}
    target=$(realpath "${VALUE#*: }")
    # echo "lnFiles: ${origin} => ${target}"

    if [ -L $target ]; then # 真实文件存在
      printf '[\e[0;33mln back\e[0m] %s\n' "$(mv -v "${target}" $BASE_PATH/bak/$(basename "${target}"))"
    fi
    printf '[\e[0;32mcopy\e[0m] '
    cp -rv "${BASE_PATH}/${origin}" "${target}"
  done
}

# 开始执行脚本
lnFiles
copyFiles

