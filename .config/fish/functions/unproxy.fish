function unproxy --description '取消代理设置'
  set -Ue http_proxy
  set -Ue https_proxy
  set -Ue all_proxy

  # 停掉http转发服务
  # brew services stop privoxy

  # git
  git config --global --unset http.proxy
  git config --global --unset https.proxy

  # npm
  npm config delete proxy
  npm config delete https-proxy
end
