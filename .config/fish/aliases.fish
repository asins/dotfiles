#Quick edits
alias vim 'mvim -v'

alias ... 'cd ../../'

alias g 'git'
alias c clear

# maven构建
alias mvn-app 'mvn clean eclipse:eclipse install -DskipTests'

#ag
alias notes 'ag "TODO|HACK|FIXME|OPTIMIZE"'

alias tnpm 'npm --registry=http://registry.npm.alibaba-inc.com'
alias cnpm 'npm --registry=https://registry.npm.taobao.org'

# 创建目录
alias md 'mkdir -p'

# 添加代理
alias setproxy 'set -Ux http_proxy socks5://127.0.0.1:1080; and set -Ux https_proxy socks5://127.0.0.1:1080'
alias unproxy 'set -Ue http_proxy; and set -Ue https_proxy'
