function unproxy --description '取消代理设置'
  set -Ue http_proxy
  set -Ue https_proxy

  # git
  git config --unset http.proxy
  git config --unset https.proxy

  # npm
  brew services stop polipo
  npm config delete proxy
  npm config delete https-proxy
end
