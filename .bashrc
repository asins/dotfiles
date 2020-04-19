# - https://github.com/asins/dotfiles
# - asinsimple@gmail.com

export PATH=/usr/local/bin:$PATH

# 目录操作
alias ..='cd ..'
alias ...='cd ../..'
alias md='mkdir -p'
alias la='ls -alh'
alias ll='ls -lh'

# 编辑器
alias vi='vim'
alias vim='mvim -v'
# VSCode
alias vsc='/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code'
# *.md
alias typora="open -a typora"

alias which='type -p'
alias k5='kill -9 %%'

alias g='git'
alias c=clear

# Nodejs & Npm
alias cnpm='npm --registry=https://registry.npm.taobao.org'

# 设置代理
function setproxy {
  HTTP_PROXY='http://127.0.0.1:8118'
  SOCK_PROXY='socks5://127.0.0.1:1080'

  if which privoxy 2>/dev/null; then
    if which brew 2>/dev/null; then
      brew services start privoxy
    else if which systemctl 2>/dev/null; then
      sudo systemctl start privoxy
    fi
  fi

  # export SOCKS_PROXY=$SOCK_PROXY
  export HTTP_PROXY=$HTTP_PROXY
  export HTTPS_PROXY=$HTTP_PROXY
  export FTP_PROXY=$HTTP_PROXY
  export NO_PROXY="localhost,127.0.0.1"


  # git
  git config --global http.proxy $SOCK_PROXY
  git config --global https.proxy $SOCK_PROXY

  # npm
  npm config set proxy $HTTP_PROXY
  npm config set https-proxy $HTTP_PROXY

  echo "已设置代理"
}


# 取消代理设置
function unproxy {
  HTTP_PROXY=''
  SOCK_PROXY=''

  if which privoxy 2>/dev/null; then
    if which brew 2>/dev/null; then
      brew services stop privoxy
    else if which systemctl 2>/dev/null; then
      sudo systemctl stop privoxy
    fi
  fi

  export HTTP_proxy=$HTTP_PROXY
  export HTTPS_PROXY=$HTTP_PROXY
  export FTP_PROXY=$HTTP_PROXY
  export NO_PROXY="localhost,127.0.0.1"

  # export SOCKS_PROXY=$SOCK_PROXY


  # git
  git config --global --unset http.proxy
  git config --global --unset https.proxy

  # npm
  npm config delete proxy
  npm config delete https-proxy

  echo "已取消代理设置"
}

