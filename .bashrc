# - https://github.com/asins/dotfiles
# - asinsimple@gmail.com

export PATH=/usr/local/bin:$PATH
export PATH=~/.local/bin:$PATH
export PATH=/usr/local/opt/node@20/bin:$PATH

PS1="\[\e[37;40m\][\[\e[33;40m\]\u\[\e[37;40m\] \[\e[36;40m\]\w\[\e[0m\]]\n\\$ "
export CLICOLOR=1

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
function setproxy() {
	HTTP_PROXY='http://127.0.0.1:8118'
	SOCK_PROXY='socks5://127.0.0.1:1080'

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
function unproxy() {
	HTTP_PROXY=''
	SOCK_PROXY=''

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

# 快速在Git仓库中提交代码审核 相当于 git push origin HEAD:refs/for/[分支名]
function pr2() {
	git_cb=$(git branch 2>/dev/null | grep \* | sed 's/* //')

	if [ -z "$git_cb" ]; then
		echo "未找到Git分支信息"
	else
		git push origin "HEAD:refs/for/$git_cb"
	fi
}

. "$HOME/.cargo/env"

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
