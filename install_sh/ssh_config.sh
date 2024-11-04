#!/bin/bash
# author: Asins<asinsimple@gmail.com>


# 检查BASE_PATH是否已定义  
if [ -z "${BASE_PATH}" ]; then  
  echo "此文件不允许单独执行，请执行外层的install.sh"  
  exit 1
fi  

# 加载基本公共方法
# source "${BASE_PATH}/@base_install.sh"

# 待复制的文件或目录
showLog "blue" "指定 ~/.ssh/config 的默认文件"
# [奇数为待复制内容的来源文件, 偶数为将要复制到哪的目标文件]
copyPathArray=(  
  #.ssh/config文件中有隐私内容所以就不做链接了以免不小心上传到github上，公司安全部的茶不好喝
  "${BASE_PATH}/.ssh/config"     "/Users/${USER_NAME}/.ssh/config"
)
lnFiles "${copyPathArray[@]}"
