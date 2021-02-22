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

pathArray=(
  "test.txt: ~/test.txt"

  # 默认的Bash
  ".bash_profile: ~/.bash_profile"
  ".bashrc: ~/.bashrc"

  # Git
  ".gitconfig: ~/.gitconfig"

  # 清歌输入法字库
  ".config/qingg.im: ~/.config/qingg.im"

  # Vim
  ".config/vim/init.vim: ~/.vimrc"
  ".config/vim: ~/.vim"

  #Nginx配置
  "nginx/nginx.conf: /usr/local/etc/nginx/nginx.conf"
  "nginx/conf.d: /usr/local/etc/nginx/conf.d"

  # nvim
  #ln -sfv $BASE/.config/nvim ~/.vim
  #ln -sfv $BASE/.config/nvim/init.vim ~/.config/nvim/init.vim

  # zsh
  #ln -sfv $BASE/.config/zsh/.zshrc ~/.zshrc

  # vscode 键盘映射
  # "vscode/keybindings.json: ~/Library/Application Support/Code/User/keybindings.json"

  #fish 配置
  ".config/fish/aliases.fish: ~/.config/fish/aliases.fish"
  ".config/fish/config.fish: ~/.config/fish/config.fish"
  ".config/fish/env.fish: ~/.config/fish/env.fish"
  ".config/fish/functions: ~/.config/fish/functions"
)

function lnFiles() {
  # mkdir -pv $BASE_PATH/bak
  for key in ${!pathArray[@]}; do
    VALUE=${pathArray[$key]}
    origin=${VALUE%%: *}
    target=$(realpath "${VALUE#*: }")
    # echo "${origin} => ${target}"

    mkdir -pv $(dirname "${target}")
    if [ -L "${target}" ]; then # 存在的是软链接
      printf '[\e[0;33mremove old ln\e[0m] '
      rm -r "${target}"
    elif [ -f "${target}" ]; then # 真实文件存在
      printf '[\e[0;33mln back\e[0m] %s\n' "$(mv -v "${target}" $BASE_PATH/bak/$(basename "${target}"))"
    fi
    printf '[\e[0;32mln -sfv\e[0m] '
    ln -sfv "${BASE_PATH}/${origin}" "${target}"
  done
}

function copyFiles() {
  # ssh
  #.ssh/config文件中有隐私内容所以就不做链接了以免不小心上传到github上，公司安全部的茶不好喝
  #ln -sfv $BASE/.ssh/config ~/.ssh/config
  target=$(realpath '~/.ssh/config')
  if [ -L $target ]; then # 真实文件存在
    mv -v $target $BASE_PATH/bak/$(basename "${target}")
  fi
  printf '[\e[0;32mcopy\e[0m] %s -> %s' ${BASE_PATH}/.ssh/config "${target}"
  cp $BASE_PATH/.ssh/config "${target}"
}

# 开始执行脚本
lnFiles
copyFiles

