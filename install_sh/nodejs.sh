#!/bin/bash
# author: Asins<asinsimple@gmail.com>


# 检查BASE_PATH是否已定义
if [ -z "${BASE_PATH}" ]; then
  echo "此文件不允许单独执行，请执行外层的install.sh"
  exit 1
fi

# 加载基本公共方法
# source "${BASE_PATH}/@base_install.sh"


# 使用volta来管理NodeJs版本
# if brew list |grep -q "volta"; then
#   showLog "green" "✓ Volta 已安装（跳过）"
# else
#   showLog "blue" "安装 Volta: NodeJs版本管理器，以及NodeJs、Pnpm"
#   brew install volta

#   volta install node
#   showLog "yellow" "安装 NodeJs LTS $(node --version)"

#   volta install pnpm
#   showLog "blue" "安装 Pnpm $(pnpm --version)"
# fi


if brew list |grep -q "node"; then
  showLog "green" "✓ NodeJs 已安装（跳过）"
else
  showLog "blue" "安装 NodeJs LTS"
  brew install node
fi


if brew list |grep -q "pnpm"; then
  showLog "green" "✓ Pnpm 已安装（跳过）"
else
  showLog "blue" "安装 Pnpm: NodeJs环境中 npm 包管理器"
  brew install pnpm
fi