#!/bin/bash
# author: Asins<asinsimple@gmail.com>


# 检查BASE_PATH是否已定义  
if [ -z "${BASE_PATH}" ]; then  
  echo "此文件不允许单独执行，请执行外层的install.sh"  
  exit 1
fi  

# 加载基本公共方法
# source "${BASE_PATH}/@base_install.sh"

if ! brew list | grep -q "fish"; then
  showLog "blue" "安装 Fish Shell"
  brew install fish
fi

# 获取 zsh 的路径
FISH_PATH=$(which fish)

# 检查 FISH_PATH 是否为空
if [ -z "${FISH_PATH}" ]; then
  showLog "red" "[Error]" "fish 未安装或未找到"
  exit 1
fi

if ! grep -q "${FISH_PATH}" "/etc/shells"; then
  showLog "blue" "将 Fish 追加到Mac Shell列表中"
  echo $FISH_PATH | sudo tee -a /etc/shells

  showLog "blue" "设置 fish 为默认 Shells"
  chsh -s $FISH_PATH
fi


if ! brew list | grep -q "starship"; then
  showLog "blue" "安装 Starship: 超级快、支持各种订制的极简命令行提示符"
  brew install starship
fi


showLog "blue" "设置 Fish 软件在 dotfiles 中的软连接"
lnArr=(
  # Fish 配置
  "${BASE_PATH}/.config/fish/aliases.fish" "/Users/${USER_NAME}/.config/fish/aliases.fish"
  "${BASE_PATH}/.config/fish/config.fish"  "/Users/${USER_NAME}/.config/fish/config.fish"
  "${BASE_PATH}/.config/fish/env.fish"     "/Users/${USER_NAME}/.config/fish/env.fish"
  "${BASE_PATH}/.config/fish/functions"    "/Users/${USER_NAME}/.config/fish/functions"
  )
lnFiles "${lnArr[@]}"


showLog "blue" "安装 Fisher: fish插件管理器"
/opt/homebrew/bin/fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher'

showLog "blue" "安装 z: fish的目录跳转插件"
/opt/homebrew/bin/fish -c 'fisher install jethrokuan/z'
