#!/bin/bash
# author: Asins<asinsimple@gmail.com>

# 检查BASE_PATH是否已定义  
if [ -z "${BASE_PATH}" ]; then  
  echo "此文件不允许单独执行，请执行外层的install.sh"  
  exit 1
fi


if [ -d "/Applications/WanNianLi.app" ]; then # 真实文件存在

  showLog "blue" "设置 WanNianLi 软件在 dotfiles 中的软连接"
  lnArr=(
    "${BASE_PATH}/WanNianLi/festivals.js"   "/Users/${USER_NAME}/Library/Application Support/com.zfdang.calendar/festivals.js"
    "${BASE_PATH}/WanNianLi/events.js"      "/Users/${USER_NAME}/Library/Application Support/com.zfdang.calendar/events.js"
  )
  lnFiles "${lnArr[@]}"
fi

