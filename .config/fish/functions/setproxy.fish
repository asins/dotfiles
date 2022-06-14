function setproxy --description "设置代理 支持 http https git命令代理"

  # 使用privoxy来将http/https的请求转发给socks5协议:
  # vim /usr/local/etc/privoxy/config
  # 设置 privoxy 监听任意 ip 的 8118 端口
  # listen-address 0.0.0.0:8118
  # 设置转发到本地的 socks5 代理客户端端口
  # forward-socks5t / 127.0.0.1:7890 .

  # 使用v2pay时可不启用privoxy
  # brew services restart privoxy

  set socksUri socks://127.0.0.1:7890
  set socks5Uri socks5://127.0.0.1:7890
  set httpUri http://127.0.0.1:7890

  set -Ux no_proxy localhost,127.0.0.1
  set -Ux all_proxy $httpUri
  set -Ux http_proxy $httpUri
  set -Ux https_proxy $httpUri

  # git
  git config --global socks.proxy $socksUri
  git config --global https.proxy $httpUri
  git config --global http.proxy $httpUri

  # npm
  npm config set proxy $httpUri
  npm config set https-proxy $httpUri
end
