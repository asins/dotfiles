#!/bin/bash
# author: Asins<asinsimple@gmail.com>

# 检查BASE_PATH是否已定义
if [ -z "${BASE_PATH}" ]; then
  echo "此文件不允许单独执行，请执行外层的install.sh"
  exit 1
fi


# MacVim配置
if ! brew list | grep -q "macvim"; then
  showLog "blue" "安装 MacVim: 代码编辑器"
  brew install macvim
  lnPaths=(
    "${BASE_PATH}/.config/vim/init.vim"  "/Users/${USER_NAME}/.vimrc"
    "${BASE_PATH}/.config/vim"           "/Users/${USER_NAME}/.vim"
  )
  lnFiles "${lnPaths[@]}"
fi


# Helix 配置
if ! brew list | grep -q "helix"; then
  showLog "blue" "安装 Helix: 后现代文本编辑器"
  brew install helix
  lnPaths=(
    "${BASE_PATH}/.config/helix"         "/Users/${USER_NAME}/.config/helix"
  )
  lnFiles "${lnPaths[@]}"
fi

# NeoVim的配置
# if ! brew list | grep -q "neovim"; then
#   showLog "blue" "安装 NeoVim: 重构 Vim kj的编辑器"
#   brew install neovim
#   lnPaths=(
#     "${BASE_PATH}/.config/nvim"            "/Users/${USER_NAME}/.vim"
#     "${BASE_PATH}/.config/nvim/init.vim"   "/Users/${USER_NAME}/.config/nvim/init.vim"
#    )
#    lnFiles "${lnPaths[@]}"
# fi

# Sublime Text
if ! brew list | grep -q "sublime-text"; then
  showLog "blue" "安装 Sublime Text: 文本编辑器,命令行: subl"
  brew install sublime-text
fi

# Zed
if ! brew list | grep -q "zed"; then
  showLog "blue" "安装 Zed: 用Rust开发的极快编辑器"
  brew install zed
  lnPaths=(
    "${BASE_PATH}/.config/zed/settings.json" "/Users/${USER_NAME}/.config/zed/settings.json"
  )
  lnFiles "${lnPaths[@]}"
fi

# VSCode
if ! brew list | grep -q "visual-studio-code"; then
  showLog "blue" "安装 VSCode"
  brew install visual-studio-code
fi
