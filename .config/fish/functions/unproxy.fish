function unproxy --description '取消代理设置'
  set -Ue all_proxy
  set -Ue http_proxy
  set -Ue https_proxy

  # 停掉http转发服务
  # brew services stop privoxy

  # npm
  npm config delete proxy
  npm config delete https-proxy

  # git
  #
  git config --global --unset socks.proxy
  git config --global --unset https.proxy
  git config --global --unset http.proxy
end
