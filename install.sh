#!/bin/bash
#
# Asins <asinsimple@gmail.com>


#RC files
cd $(dirname $BASH_SOURCE)
BASE=$(pwd)

for rc in .*rc .tmux.conf .agignore; do
	mkdir -pv bak
	[ -e ~/$rc ] && mv -v ~/$rc bak/$rc
	ln -sfv $BASE/$rc ~/$rc
done

#nvim
ln -sfv $BASE/.config/nvim/init.vim ~/.config/nvim/init.vim


# scripts
#mkdir -p ~/.bin
#for bin in $BASE/.bin/*; do
#	ln -sfv $bin ~/.bin
#done

# ssh
mkdir ~/.ssh
ln -sfv $BASE/.ssh/config ~/.ssh/config

if [ $(uname -s) = 'Darwin' ]; then
	# Homebrew
	[ -z "$(which brew)" ] &&
		ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

	echo "Updating homebrew"
	brew install \
		git ag coreutils wget cscope ctags tree highlight \
		fish tmux autojump vim neovim fzf node

	command -v blsd > /dev/null ||
		(bash <(curl -fL https://raw.githubusercontent.com/junegunn/blsd/master/install) && mv blsd ~/bin)

	command -v fisher > /dev/null ||
		(bash <(curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisherman))

	brew cask install iterm2 qq mplayerx java java7 imageoptim sublime-text
fi

tmux source-file ~/.tmux.conf
