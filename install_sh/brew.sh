#!/bin/bash
# author: Asins<asinsimple@gmail.com>

# 检查BASE_PATH是否已定义
if [ -z "${BASE_PATH}" ]; then
  echo "此文件不允许单独执行，请执行外层的install.sh"
  exit 1
fi

# 加载基本公共方法
# source "${BASE_PATH}/@base_install.sh"

if [ -z "$(which brew)" ]; then
  showLog "blue" "安装 Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  showLog "blue" "Add Brew Tap"
  brew tap homebrew/services
  brew tap buo/cask-upgrade
fi


if ! brew list | grep -q "ripgrep"; then
  showLog "blue" "安装 Rg: 全文搜索工具"
  brew install ripgrep
fi

if [ -z "$(which fd)" ]; then
  showLog "blue" "安装 Fd: 文件搜索工具"
  brew install fd
fi

