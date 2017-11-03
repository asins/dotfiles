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
ln -sfv $BASE/.config/fish/aliases.fish ~/.config/fish/aliases.fish
ln -sfv $BASE/.config/fish/config.fish ~/.config/fish/config.fish
ln -sfv $BASE/.config/fish/env.fish ~/.config/fish/env.fish
ln -sfv $BASE/.config/fish/functions ~/.config/fish/functions


# scripts
#mkdir -p ~/.bin
#for bin in $BASE/.bin/*; do
#	ln -sfv $bin ~/.bin
#done

# ssh
mkdir ~/.ssh
#ln -sfv $BASE/.ssh/config ~/.ssh/config
cp $BASE/.ssh/config ~/.ssh/config

if [ $(uname -s) = 'Darwin' ]; then
	# Homebrew
	[ -z "$(which brew)" ] &&
		ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

	echo "Updating homebrew"
	brew install \
		git ag coreutils wget cscope ctags tree highlight \
		fish autojump vim neovim fzf node

	command -v blsd > /dev/null ||
		(bash <(curl -fL https://raw.githubusercontent.com/junegunn/blsd/master/install) && mv blsd ~/bin)

	command -v fisher > /dev/null ||
		(bash <(curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisherman))

	brew cask install iterm2 qq mplayerx java java7 imageoptim sublime-text
fi
