function unproxy --description '取消代理设置'
  set -Ue all_proxy
  set -Ue http_proxy
  set -Ue https_proxy

  # 停掉http转发服务
  # brew services stop privoxy

  # git
  if command -v git > /dev/null
    git config --global --unset socks.proxy
    git config --global --unset https.proxy
    git config --global --unset http.proxy
  end

  # npm
  if command -v npm > /dev/null
    npm config -g delete proxy
    npm config -g delete https-proxy
    npm config -g set registry https://registry.npmjs.org/
  end

  # pnpm
  if command -v pnpm > /dev/null
    pnpm config -g set registry https://registry.npmjs.org/
  end

end
