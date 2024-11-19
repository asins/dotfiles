#!/bin/bash
# author: Asins<asinsimple@gmail.com>

# 检查BASE_PATH是否已定义
if [ -z "${BASE_PATH}" ]; then
  echo "此文件不允许单独执行，请执行外层的install.sh"
  exit 1
fi

if [ -z "$(which nginx)" ]; then
  showLog "blue" "安装 Nginx: Http服务"
  brew install nginx


  #nginx log目录
  sudo mkdir -pv "/var/log/nginx"

  showLog "blue" "设置 Nginx 软件在 dotfiles 中的软连接"
  lnArr=(
    # Nginx配置
    "${BASE_PATH}/nginx/nginx.conf"   "/opt/homebrew/etc/nginx/nginx.conf"
    "${BASE_PATH}/nginx/servers"      "/opt/homebrew/etc/nginx/servers"
    "${BASE_PATH}/nginx/ssl"         "/opt/homebrew/etc/nginx/ssl"
  )
  lnFiles "${lnArr[@]}"
fi

