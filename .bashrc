# - https://github.com/asins/dotfiles
# - asinsimple@gmail.com

ext() {
  local name=$(basename $(pwd))
  cd ..
  tar -cvzf "$name.tgz" --exclude .git --exclude target --exclude "*.log" "$name"
  cd -
  mv ../"$name".tgz .
}



gitzip() {
  git archive -o $(basename $PWD).zip HEAD
}

gittgz() {
  git archive -o $(basename $PWD).tgz HEAD
}

gitdiffb() {
  if [ $# -ne 2 ]; then
    echo two branch names required
    return
  fi
  git log --graph \
  --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' \
  --abbrev-commit --date=relative $1..$2
}

make-patch() {
  local name="$(git log --oneline HEAD^.. | awk '{print $2}')"
  git format-patch HEAD^.. --stdout > "$name.patch"
}

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

# maven构建
alias mvn-app='mvn clean eclipse:eclipse install -DskipTests'

# Nodejs & Npm
alias tnpm='npm --registry=http://registry.npm.alibaba-inc.com'
alias cnpm='npm --registry=https://registry.npm.taobao.org'

# 添加代理
alias setproxy='export http_proxy=socks5://127.0.0.1:1080; export https_proxy=socks5://127.0.0.1:1080'
alias unproxy='export http_proxy=; export https_proxy='

