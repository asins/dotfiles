#!/bin/bash
# author: Asins<asinsimple@gmail.com>

# 检查BASE_PATH是否已定义
if [ -z "${BASE_PATH}" ]; then
  echo "此文件不允许单独执行，请执行外层的install.sh"
  exit 1
fi


# if brew list | grep -q "qingg"; then
  # showLog "green" "✓ Qingg 已安装（跳过）"
# else
#   showLog "blue" "安装 Qingg: 五笔输入法"
#   brew install qingg
# fi


# Rime 五笔输入法
if brew list | grep -q "squirrel-app"; then
  showLog "green" "✓ Rime 已安装（跳过）"
else
  showLog "blue" "安装 Rime: 五笔输入法"
  brew install squirrel-app
fi

# Clone Rime码表仓库
TARGET_DIR=~/Development/rime-wubi86-jidian
RIME_GIT_URL="https://github.com/asins/rime-wubi86-jidian"
if [ -d "$TARGET_DIR" ]; then
    showLog "green" "✓ Rime 五笔词库码表目录 已存在: $TARGET_DIR"
else
    showLog "blue" "📦 准备克隆到: $TARGET_DIR"
    mkdir -p "$(dirname "$TARGET_DIR")"
    git clone "${RIME_GIT_URL}.git" "$TARGET_DIR" && showLog "green" "✅ 克隆成功" || showLog "red" "❌ 克隆失败"
fi

# Link Rime码表配置
if [ -L "/Users/${USER_NAME}/Library/Rime" ]; then
  showLog "green" "✓ Rime 五笔词库码表 Link 已存在: ~/Library/Rime"
else
  showLog "blue" "指定 Rime 的五笔词库码表"
  # [奇数为待复制内容的来源文件, 偶数为将要复制到哪的目标文件]
  lnPaths=(
    "$TARGET_DIR"     "/Users/${USER_NAME}/Library/Rime"
  )
  lnFiles "${lnPaths[@]}"
fi

