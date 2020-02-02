function setproxy --description "设置代理 支持 http https git命令代理"

# 安装polipo 在文件中添加设置`socksParentProxy`，变成如下样子：
# file: /usr/local/Cellar/polipo/1.1.1/homebrew.mxcl.polipo.plist
# <array>
#   <string>/usr/local/opt/polipo/bin/polipo</string>
#   <string>socksParentProxy=localhost:1080</string>
# </array>

  brew services restart polipo

  # set ssrUri '127.0.0.1:1080'
  set ssrUri '127.0.0.1:13659'
  set httpUri '127.0.0.1:8123'

  set -Ux http_proxy http://$httpUri
  set -Ux https_proxy http://$httpUri

  # git
  git config http.proxy socks5://$ssrUri
  git config https.proxy socks5://$ssrUri

  # npm
  npm config set proxy http://$httpUri
  npm config set https-proxy http://$httpUri
end
