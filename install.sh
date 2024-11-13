#!/bin/bash
# author: Asins<asinsimple@gmail.com>

# 加载基本公共方法
source ./install_sh/@base_install.sh

# 确保备份目录存在
mkdir -pv $BASE_PATH/bak

#nginx log目录
# sudo mkdir -pv "/var/log/nginx"


lnPathArray=(
  # 默认的Bash
  "${BASE_PATH}/.bash_profile"             "/Users/${USER_NAME}/.bash_profile"
  "${BASE_PATH}/.bashrc"                   "/Users/${USER_NAME}/.bashrc"
  # "${BASE_PATH}/bin"                     "/Users/${USER_NAME}/.bin"

  # Git
  "${BASE_PATH}/.gitconfig"                "/Users/${USER_NAME}/.gitconfig"

  # 清歌输入法字库
  # "${BASE_PATH}/qingg.im"                "/Users/${USER_NAME}/.config/qingg.im"

  # Zed编辑器
  "${BASE_PATH}/.config/zed/settings.json" "/Users/${USER_NAME}/.config/zed/settings.json"

  # Vim
  "${BASE_PATH}/.config/vim/init.vim"      "/Users/${USER_NAME}/.vimrc"
  "${BASE_PATH}/.config/vim"               "/Users/${USER_NAME}/.vim"

  # alacritty终端应用
  "${BASE_PATH}/.config/alacritty"         "/Users/${USER_NAME}/.config/alacritty"
  "${BASE_PATH}/.config/neofetch"          "/Users/${USER_NAME}/.config/neofetch"

  # nvim
  # "${BASE_PATH}/.config/nvim"            "/Users/${USER_NAME}/.vim"
  # "${BASE_PATH}/.config/nvim/init.vim"   "/Users/${USER_NAME}/.config/nvim/init.vim"

  # zsh
  "${BASE_PATH}/.config/zsh/.zshrc"        "/Users/${USER_NAME}/.zshrc"
)
lnFiles "${lnPathArray[@]}"


# 开始执行脚本
source "${BASE_PATH}/install_sh/brew.sh"
source "${BASE_PATH}/install_sh/nginx.sh"
source "${BASE_PATH}/install_sh/nodejs.sh"
source "${BASE_PATH}/install_sh/fish.sh"
source "${BASE_PATH}/install_sh/ssh_config.sh"
source "${BASE_PATH}/install_sh/WanNianLi.sh"
