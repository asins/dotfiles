#!/bin/bash
# author: Asins<asinsimple@gmail.com>

# 检查BASE_PATH是否已定义
if [ -z "${BASE_PATH}" ]; then
  echo "此文件不允许单独执行，请执行外层的install.sh"
  exit 1
fi


if ! brew list | grep -q "maccy"; then
  showLog "blue" "安装 Maccy: 多剪贴板工具"
  brew install maccy
fi

if ! brew list | grep -q "imageoptim"; then
  showLog "blue" "安装 Imageoptim: 图片无损压缩工具"
  brew install imageoptim
fi

if ! brew list | grep -q "switchhosts"; then
  showLog "blue" "安装 Switchhosts: 本地Hosts快速切换工具"
  brew install switchhosts
fi

if ! brew list | grep -q "google-chrome"; then
  showLog "blue" "安装 Chrome: 浏览器"
  brew install google-chrome
fi


if ! brew list | grep -q "iina"; then
  showLog "blue" "安装 IINA: 视频播放器"
  brew install iina
fi

if ! brew list | grep -q "eudic"; then
  showLog "blue" "安装 Eudic: 英文词典"
  brew install eudic
fi

if ! brew list | grep -q "qingg"; then
  showLog "blue" "安装 Qing: 五笔输入法"
  brew install qingg
fi

