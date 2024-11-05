#!/bin/bash
# author: Asins<asinsimple@gmail.com>


# 检查BASE_PATH是否已定义  
if [ -z "${BASE_PATH}" ]; then  
  echo "此文件不允许单独执行，请执行外层的install.sh"  
  exit 1
fi  

# 加载基本公共方法
# source "${BASE_PATH}/@base_install.sh"

if ! brew list |grep -q "volta"; then
  showLog "blue" "安装 Volta: NodeJs版本管理器"
  brew install volta

  volta install node
  showLog "yellow" "安装 NodeJs LTS $(node --version)"

  volta install pnpm
  showLog "blue" "安装 Pnpm $(pnpm --version)"
fi
