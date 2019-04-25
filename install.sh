#!/bin/bash
#
# Asins <asinsimple@gmail.com>


#RC files
cd $(dirname $BASH_SOURCE)
BASE=$(pwd)

for rc in .*rc .agignore; do
	mkdir -pv bak
	[ -e ~/$rc ] && mv -v ~/$rc bak/$rc
	ln -sfv $BASE/$rc ~/$rc
done

# vim相关文件
ln -sfv $BASE/.config/vim ~/.vim
ln -sfv $BASE/.config/vim/init.vim ~/.vimrc

# 清歌输入法字库
ln -sfv $BASE/.config/qingg.im  ~/.config/qingg.im

# nvim
#ln -sfv $BASE/.config/nvim ~/.vim
#ln -sfv $BASE/.config/nvim/init.vim ~/.config/nvim/init.vim

# zsh
#ln -sfv $BASE/.config/zsh/.zshrc ~/.zshrc

# scripts
#mkdir -p ~/.bin
#for bin in $BASE/.bin/*; do
#	ln -sfv $bin ~/.bin
#done

# ssh
mkdir ~/.ssh
#.ssh/config文件中有隐私内容所以就不做链接了以免不小心上传到github上，公司安全部的茶不好喝
#ln -sfv $BASE/.ssh/config ~/.ssh/config
cp $BASE/.ssh/config ~/.ssh/config

if [ $(uname -s) = 'Darwin' ]; then
	# Homebrew
	[ -z "$(which brew)" ] &&
		ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

	echo "Updating homebrew"
	brew install \
		git coreutils wget cscope ctags tree highlight \
    fish macvim node

	echo "Install brew cask"
	brew tap caskroom/cask

	# echo "Install zsh"
	# sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
	# echo $(which zsh) | sudo tee -a /etc/shells
	# chsh -s $(which zsh)

  # 安装常用软件
	brew cask install \
    iterm2 java \
    charles sublime-text typora clipy imageoptim switchhosts \
    firefox-developer-edition google-chrome google-chrome-canary \
    qq iina eudic enpass neteasemusic qingg

  # fish shell安装
  brew cask install fish
  # 将fish添加到mac shell列表中
  sudo bash -c "echo '/usr/local/bin/fish' >> /etc/shells"
  # fish 配置
  ln -sfv $BASE/.config/fish/aliases.fish ~/.config/fish/aliases.fish
  ln -sfv $BASE/.config/fish/config.fish ~/.config/fish/config.fish
  ln -sfv $BASE/.config/fish/env.fish ~/.config/fish/env.fish
  ln -sfv $BASE/.config/fish/functions ~/.config/fish/functions
  # 安装fish的包管理工具
  curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
  # fisher的插件需要自己执行添加
  # fisher add jethrokuan/z
  # fisher add rafaelrinaldi/pure

fi
