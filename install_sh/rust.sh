#!/bin/bash
# author: Asins<asinsimple@gmail.com>

# 检查BASE_PATH是否已定义
if [ -z "${BASE_PATH}" ]; then
  echo "此文件不允许单独执行，请执行外层的install.sh"
  exit 1
fi

if [ -z "$(which rustc)" ]; then
  showLog "blue" "安装 Rust"
  brew install rustup
  rustup-init
fi

