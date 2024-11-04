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

if ! brew list | grep -q "git"; then
  showLog "blue" "安装 Git"
  brew install git
fi

if ! brew list | grep -q "lazygit"; then
  showLog "blue" "安装 LazyGit: Git命令的简单终端用户界面"
  brew install lazygit
fi

if [ -z "$(which mvim)" ]; then
  showLog "blue" "安装 MacVim: 代码编辑器"
  brew install macvim
fi

if [ -z "$(which nginx)" ]; then
  showLog "blue" "安装 Nginx: Http服务"
  brew install nginx
fi

if [ -z "$(which rg)" ]; then
  showLog "blue" "安装 Rg: 全文搜索工具"
  brew install ripgrep
fi

if [ -z "$(which fd)" ]; then
  showLog "blue" "安装 Fd: 文件搜索工具"
  brew install fd
fi

if [ -z "$(which rustc)" ]; then
  showLog "blue" "安装 Rust"
  brew install rustup
  rustup-init
fi


# ========== 安装带 UI 的常用软件 ========== 

if [ -z "$(which subl)" ]; then
  showLog "blue" "安装 Sublime Text: 文本编辑器"
  brew install sublime-text
fi

if ! brew list | grep -q "maccy"; then
  showLog "blue" "安装 Maccy: 多剪贴板工具"
  brew install maccy
fi

if ! brew list | grep -q "imageoptim"; then
  showLog "blue" "安装 Imageoptim: 图片无损压缩工具"
  brew install imageoptim
fi

if ! brew list | grep -q "switchhosts"; then
  showLog "blue" "安装 Switchhosts: 本地Hosts快速切换工具"
  brew install switchhosts
fi

if ! brew list | grep -q "google-chrome"; then
  showLog "blue" "安装 Chrome: 浏览器"
  brew install google-chrome
fi


if ! brew list | grep -q "iina"; then
  showLog "blue" "安装 IINA: 视频播放器"
  brew install iina
fi

if ! brew list | grep -q "eudic"; then
  showLog "blue" "安装 Eudic: 英文词典"
  brew install eudic
fi

if ! brew list | grep -q "qingg"; then
  showLog "blue" "安装 Qing: 五笔输入法"
  brew install qingg
fi
