#!/bin/bash
# author: Asins<asinsimple@gmail.com>

cd "$(dirname $BASH_SOURCE)/../"
BASE_PATH=$(pwd)
USER_NAME="asins"
echo "项目根目录: ${BASE_PATH}"

# 确保备份目录存在
# mkdir -pv $BASE_PATH/bak


# 对文件或目录做系统软连接
function lnFiles() {
  local lnPathArray=("$@")  # 将传入的所有参数存储为数组

  local len=${#lnPathArray[@]}
  for ((i=0; i<len; i+=2)); do
    local origin=${lnPathArray[i]}
    local target=${lnPathArray[i+1]}

    # 检查源路径是否存在
    if [ ! -e "$origin" ]; then
      showLog "red" "skip" "${origin} does not exist"
      continue
    fi

    local targetDir=$(dirname "${target}")
    # 目标目录不存在时自动创建
    if ! [ -d "${targetDir}" ]; then
      mkdir -pv "${targetDir}"
      showLog "blue" "mkdir success" "${targetDir}";
    fi

    if [ -L "${target}" ]; then # 存在的是软链接
      showLog "yellow" "remove old ln" "${target}"
      rm -r "${target}"
    elif [ -f "${target}" ]; then # 真实文件存在
      showLog "yellow" "ln back" "$(mv -v "${target}" $BASE_PATH/bak/$(basename "${target}"))"
    elif [ -d "${target}" ]; then # 真实目录存在
      showLog "yellow" "ln back" "$(mv -v "${target}" $BASE_PATH/bak/$(basename "${target}"))"
    fi

    showLog "green" "ln -sfv" "$(ln -sfv "${origin}" "${target}")"
  done
}

# 复制文件到另一个位置
function copyFiles() {
  local copyPathArray=("$@")  # 将传入的所有参数存储为数组

  local len=${#copyPathArray[@]}
  for ((i=0; i<len; i+=2)); do
    local origin=${copyPathArray[i]}
    local target=${copyPathArray[i+1]}

    
    # 检查源路径是否存在
    if [ ! -e "$origin" ]; then
      showLog "red" "skip" "${origin} does not exist"
      continue
    fi
    
    if [ -L $target ]; then # 目标文件已存在
      showLog "yellow" "ln back" "$(mv -v "${target}" ${BASE_PATH}/bak/$(basename "${target}"))"
    fi

    showLog "green" "copy" "$(cp -rv "${origin}" "${target}")"
  done
}

# 用于打印日志的
# log 颜色, 颜色对应的字符，普通字符
function showLog() {
  local color_code=$1
  local colored_message=$2
  local normal_message=$3

  # 定义颜色代码
  local RED='\033[0;31m'
  local GREEN='\033[0;32m'
  local YELLOW='\033[0;33m'
  local BLUE='\033[0;34m'
  local PURPLE='\033[0;35m'
  local CYAN='\033[0;36m'
  local WHITE='\033[0;37m'
  local NC='\033[0m' # No Color

  # 根据颜色代码选择颜色
  case $color_code in
    "red") color=$RED ;;
    "green") color=$GREEN ;;
    "yellow") color=$YELLOW ;;
    "blue") color=$BLUE ;;
    "purple") color=$PURPLE ;;
    "cyan") color=$CYAN ;;
    "white") color=$WHITE ;;
    *) color=$NC ;; # 默认无颜色
  esac

  # 打印日志
  echo -e "[${color}$(date +'%Y-%m-%d %H:%M:%S')${NC}] ${color}${colored_message}${NC} ${normal_message}"
}
