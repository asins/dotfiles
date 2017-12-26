# 目录操作
alias ..='cd ..'
alias ...='cd ../..'
alias md='mkdir -p'
alias la='ls -alh'
alias ll='ls -lh'

# 编辑器
alias vi='vim'
alias vim='mvim -v'
alias gv='vim +GV +"autocmd BufWipeout <buffer> qall"'
# VSCode
alias vsc='/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code'
# *.md
alias typora="open -a typora"

alias hc="history -c"
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