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

# nvim
#ln -sfv $BASE/.config/nvim/init.vim ~/.config/nvim/init.vim

# macvim
ln -sfv $BASE/.config/vim/init.vim ~/.vimrc

# fish
#ln -sfv $BASE/.config/fish/aliases.fish ~/.config/fish/aliases.fish
#ln -sfv $BASE/.config/fish/config.fish ~/.config/fish/config.fish
#ln -sfv $BASE/.config/fish/env.fish ~/.config/fish/env.fish
#ln -sfv $BASE/.config/fish/functions ~/.config/fish/functions

# zsh
ln -sfv $BASE/.config/zsh/.zshrc ~/.zshrc

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
		zsh z vim node

	echo "Install brew cask"
	brew tap caskroom/cask

	echo "Install zsh"
	sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
	echo $(which zsh) | sudo tee -a /etc/shells
	chsh -s $(which zsh)

	brew cask install iterm2 qq mplayerx java imageoptim sublime-text
fi
