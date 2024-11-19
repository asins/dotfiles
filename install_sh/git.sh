#!/bin/bash
# author: Asins<asinsimple@gmail.com>

# 检查BASE_PATH是否已定义
if [ -z "${BASE_PATH}" ]; then
  echo "此文件不允许单独执行，请执行外层的install.sh"
  exit 1
fi

if ! brew list | grep -q "git"; then
  showLog "blue" "安装 Git"
  brew install git
  # Git 配置
  lnPaths=(
    "${BASE_PATH}/.gitconfig"     "/Users/${USER_NAME}/.gitconfig"
  )
  lnFiles "${lnPaths[@]}"
fi

if ! brew list | grep -q "lazygit"; then
  showLog "blue" "安装 LazyGit: Git命令的简单终端用户界面"
  brew install lazygit
fi

