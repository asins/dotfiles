#!/bin/bash
# author: Asins<asinsimple@gmail.com>


# 检查BASE_PATH是否已定义
if [ -z "${BASE_PATH}" ]; then
  echo "此文件不允许单独执行，请执行外层的install.sh"
  exit 1
fi


# =========== 默认终端 ===========

if ! [ -L "/Users/${USER_NAME}/.bashrc" ]; then
  showLog "blue" "开始配置 默认终端 bash / zsh"
  lnArr=(
    # 默认的Bash
    "${BASE_PATH}/.bash_profile"             "/Users/${USER_NAME}/.bash_profile"
    "${BASE_PATH}/.bashrc"                   "/Users/${USER_NAME}/.bashrc"

    # zsh
    "${BASE_PATH}/.config/zsh/.zshrc"        "/Users/${USER_NAME}/.zshrc"
    )
  lnFiles "${lnArr[@]}"
fi


# =========== Ssh 配置 ===========

if ! [ -L "/Users/${USER_NAME}/.ssh/config" ]; then
  showLog "blue" "指定 ~/.ssh/config 的默认文件"
  # [奇数为待复制内容的来源文件, 偶数为将要复制到哪的目标文件]
  lnPaths=(
    #.ssh/config文件中有隐私内容所以就不做链接了以免不小心上传到github上，公司安全部的茶不好喝
    "${BASE_PATH}/.ssh/config"     "/Users/${USER_NAME}/.ssh/config"
  )
  lnFiles "${lnPaths[@]}"
fi


# =========== Fish 终端 ===========

if ! brew list | grep -q "fish"; then
  showLog "blue" "安装 Fish Shell"
  brew install fish
  showLog "blue" "配置 Fish 软件在 dotfiles 中的软连接"
  lnArr=(
    # Fish 配置
    "${BASE_PATH}/.config/fish/aliases.fish" "/Users/${USER_NAME}/.config/fish/aliases.fish"
    "${BASE_PATH}/.config/fish/config.fish"  "/Users/${USER_NAME}/.config/fish/config.fish"
    "${BASE_PATH}/.config/fish/env.fish"     "/Users/${USER_NAME}/.config/fish/env.fish"
    "${BASE_PATH}/.config/fish/functions"    "/Users/${USER_NAME}/.config/fish/functions"
    )
  lnFiles "${lnArr[@]}"

  # 获取 fish 的路径
  FISH_PATH=$(which fish)


  # 将fish shell 加入常用shell列表
  if ! grep -q "${FISH_PATH}" "/etc/shells"; then
    showLog "blue" "将 Fish 追加到Mac Shell列表中"
    echo $FISH_PATH | sudo tee -a /etc/shells

    showLog "blue" "设置 fish 为默认 Shells"
    sudo chsh -s $FISH_PATH
  fi
fi


if ! brew list | grep -q "alacritty"; then
  showLog "blue" "安装 Alacritty: GPU 加速的终端仿真器"
  brew install alacritty
  # Alacritty 配置
  lnPaths=(
    "${BASE_PATH}/.config/alacritty"      "/Users/${USER_NAME}/.config/alacritty"
  )
  lnFiles "${lnPaths[@]}"
fi


if ! brew list | grep -q "starship"; then
  showLog "blue" "安装 Starship: 超级快、支持各种订制的极简命令行提示符"
  brew install starship
fi

if ! brew list | grep -q "zoxide"; then
  showLog "blue" "安装 Zoxide: 更智能的 cd 命令(支持快速跳转)"

  brew install zoxide
fi

