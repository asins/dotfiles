#!/bin/bash
#
# Asins <asinsimple@gmail.com>


#RC files
cd $(dirname $BASH_SOURCE)
BASE_PATH=$(pwd)

declare -A map=(
  # 默认的Bash
  [".bash_profile"]="~/.bash_profile"
  [".bashrc"]="~/.bashrc"

  # Git
  [".gitconfig"]="~/.gitconfig"

  # 清歌输入法字库
  [".config/qingg.im"]="~/.config/qingg.im"

  # Vim
  [".config/vim/init.vim"]="~/.vimrc"
  [".config/vim"]="~/.vim"

  #Nginx配置
  ["nginx/nginx.conf"]="/usr/local/etc/nginx/nginx.conf"
  ["nginx/conf.d"]="/usr/local/etc/nginx/conf.d"

  #SSH
  [".ssh/config"]="~/.ssh/config"

  # nvim
  #ln -sfv $BASE/.config/nvim ~/.vim
  #ln -sfv $BASE/.config/nvim/init.vim ~/.config/nvim/init.vim

  # zsh
  #ln -sfv $BASE/.config/zsh/.zshrc ~/.zshrc

  #fish 配置
  [".config/fish/aliases.fish"]="~/.config/fish/aliases.fish"
  [".config/fish/config.fish"]="~/.config/fish/config.fish"
  [".config/fish/env.fish"]="~/.config/fish/env.fish"
  [".config/fish/functions"]="~/.config/fish/functions"

)

mkdir -pv $BASE_PATH/bak
for origin in ${!map[@]}; do
  target=${map[$origin]}
  mkdir -pv $(dirname $target)
  if [ -L $target ]; then # 真实文件存在
    mv -v $target $BASE_PATH/bak/$(basename $target)
  elif [ -e $target ]; then # 存在的是软链接
    rm ~/$rc
  fi
  ln -sfv $BASE_PATH/$origin $target
done

# scripts
#mkdir -p ~/.bin
#for bin in $BASE/.bin/*; do
#	ln -sfv $bin ~/.bin
#done

# ssh
#.ssh/config文件中有隐私内容所以就不做链接了以免不小心上传到github上，公司安全部的茶不好喝
#ln -sfv $BASE/.ssh/config ~/.ssh/config
target=~/.ssh/config
if [ -L $target ]; then # 真实文件存在
  mv -v $target $BASE_PATH/bak/$(basename $target)
fi
cp $BASE_PATH/.ssh/config $target
