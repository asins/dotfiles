#!/bin/bash
# author: Asins<asinsimple@gmail.com>

# 检查BASE_PATH是否已定义
if [ -z "${BASE_PATH}" ]; then
  echo "此文件不允许单独执行，请执行外层的install.sh"
  exit 1
fi

# if [ -n "$(which rustc)" ]; then
if brew list |grep -q "rustup"; then
  showLog "green" "✓ Rust 已安装（跳过）"
else
  showLog "blue" "安装 Rust"
  brew install rustup
  rustup-init
fi

