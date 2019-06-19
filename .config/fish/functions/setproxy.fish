function setproxy --description "设置代理 支持 http https git命令代理"

# 安装polipo 在文件中添加设置`socksParentProxy`，变成如下样子：
# file: /usr/local/Cellar/polipo/1.1.1/homebrew.mxcl.polipo.plist
# <array>
#   <string>/usr/local/opt/polipo/bin/polipo</string>
#   <string>socksParentProxy=localhost:1080</string>
# </array>

  brew services restart polipo

  set -Ux http_proxy http://127.0.0.1:8123
  set -Ux https_proxy http://127.0.0.1:8123

  # git
  git config http.proxy 'socks5://127.0.0.1:1080'
  git config https.proxy 'socks5://127.0.0.1:1080'

  # npm
  npm config set proxy http://127.0.0.1:8123
  npm config set https-proxy http://127.0.0.1:8123
end
