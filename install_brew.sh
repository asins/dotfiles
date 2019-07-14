#!/bin/bash
#
# Asins <asinsimple@gmail.com>

# if [ $(uname -s) = 'Darwin' ]; then

# Homebrew
if [ -z "$(which brew)" ]; then
  echo "Install homebrew...."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

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

# fi
