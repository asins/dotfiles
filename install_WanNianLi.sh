#!/bin/bash
#
# Asins <asinsimple@gmail.com>


#RC files
cd $(dirname $BASH_SOURCE)
BASE_PATH=$(pwd)


# 万年历数据指向
WanNianLi_Folder="${HOME}/Library/Application Support/com.zfdang.calendar"
WanNianLi_Back="${BASE_PATH}/bak/WanNianLi/"

if [ -d "$WanNianLi_Folder" ]; then # 真实文件存在
  if [ ! -d "$WanNianLi_Back" ]; then
    mkdir -pv $WanNianLi_Back
  fi

  if [ -f "${WanNianLi_Folder}/festivals.js" ]; then # 真实文件存在
    mv -v "${WanNianLi_Folder}/festivals.js" $WanNianLi_Back
  elif [ -L $target ]; then # 存在的是软链接
    rm "${WanNianLi_Folder}/festivals.js"
  fi

  if [ -f "${WanNianLi_Folder}/events.js" ]; then # 真实文件存在
    mv -v "${WanNianLi_Folder}/events.js" $WanNianLi_Back
  elif [ -L $target ]; then # 存在的是软链接
    rm "${WanNianLi_Folder}/events.js"
  fi

  ln -sfv "${BASE_PATH}/WanNianLi/festivals.js" "${WanNianLi_Folder}/festivals.js"
  ln -sfv "${BASE_PATH}/WanNianLi/events.js" "${WanNianLi_Folder}/events.js"
fi

