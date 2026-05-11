#!/bin/bash
# author: Asins<asinsimple@gmail.com>

# 检查BASE_PATH是否已定义
if [ -z "${BASE_PATH}" ]; then
  echo "此文件不允许单独执行，请执行外层的install.sh"
  exit 1
fi

if [ -n "$(which nginx)" ]; then
  showLog "green" "✓ Nginx 已安装（跳过）"
else
  showLog "blue" "安装 Nginx: Http服务"
  brew install nginx
fi

NGINX_CONFIG_PATH="/opt/homebrew/etc/nginx/nginx.conf"
if [ -L "${NGINX_CONFIG_PATH}" ]; then
  showLog "green" "✓ Nginx 配置文件 已经 Link（跳过）"
else
  #nginx log目录
  sudo mkdir -pv "/var/log/nginx"

  showLog "blue" "设置 Nginx 软件在 dotfiles 中的软连接"
  lnArr=(
    # Nginx配置
    "${BASE_PATH}/nginx/nginx.conf"   "$NGINX_CONFIG_PATH"
    "${BASE_PATH}/nginx/servers"      "/opt/homebrew/etc/nginx/servers"
    "${BASE_PATH}/nginx/ssl"         "/opt/homebrew/etc/nginx/ssl"
  )
  lnFiles "${lnArr[@]}"
fi
