#!/bin/bash
# author: Asins<asinsimple@gmail.com>

# 加载基本公共方法
source ./install_sh/@base_install.sh

# 确保备份目录存在
mkdir -pv $BASE_PATH/bak


# 开始执行脚本
source "${BASE_PATH}/install_sh/brew.sh"
source "${BASE_PATH}/install_sh/nginx.sh"
source "${BASE_PATH}/install_sh/nodejs.sh"
source "${BASE_PATH}/install_sh/git.sh"
source "${BASE_PATH}/install_sh/terminals.sh"
source "${BASE_PATH}/install_sh/editors.sh"
source "${BASE_PATH}/install_sh/rust.sh"
source "${BASE_PATH}/install_sh/ui_apps.sh"
source "${BASE_PATH}/install_sh/WanNianLi.sh"
