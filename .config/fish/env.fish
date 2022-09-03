# 此文件仅在登录shell时执行（负责设置初始环境）。
set -gx PATH /bin
set -gx PATH /sbin $PATH
set -gx PATH /usr/bin $PATH
set -gx PATH /usr/sbin $PATH
set -gx PATH /opt/homebrew/bin $PATH
set -gx PATH /usr/local/sbin $PATH
set -gx PATH /usr/local/bin $PATH
fish_add_path ~/.bin

# brew源改为阿里云
# set -gx HOMEBREW_BOTTLE_DOMAIN https://mirrors.aliyun.com/homebrew/homebrew-bottles
set -gx HOMEBREW_BOTTLE_DOMAIN https://mirrors.ustc.edu.cn/homebrew-bottles

# java运行环境变量
# set -gx JAVA_HOME (/usr/libexec/java_home -F)
set -gx PATH /opt/homebrew/opt/openjdk/bin $PATH
# set -gx M2_HOME "/usr/local/opt/maven/libexec"
set -gx CPPFLAGS "-I/opt/homebrew/opt/openjdk/include"

# java旧版
# set -gx TOMCAT_HOME "/usr/local/opt/tomcat@7/libexec"
# fish_add_path $TOMCAT_HOME/bin
# fish_add_path $M2_HOME/bin

# Rust
set -gx PATH  ~/.cargo/bin $PATH
# set -gx RUST_SRC_PATH "/usr/local/opt/rust"
set -gx PKG_CONFIG_PATH $PKG_CONFIG_PATH "/usr/local/opt/icu4c/lib/pkgconfig"

# pnpm
set -gx PNPM_HOME "~/Library/pnpm"
set -gx PATH ~/Library/pnpm $PATH

# openssl
# set -g fish_user_paths /usr/local/opt/curl/bin $fish_user_paths
# set -gx LDFLAGS "-L/usr/local/opt/curl/lib"
# set -gx CPPFLAGS "-I/usr/local/opt/curl/include"
# set -gx PKG_CONFIG_PATH $PKG_CONFIG_PATH  "/usr/local/opt/curl/lib/pkgconfig"

# Android开发: adb命令
# set -gx ANDROID_HOME "~/Library/Android/sdk"
# fish_add_path $ANDROID_HOME/tools
# fish_add_path $ANDROID_HOME/platform-tools

# Flutter镜像
# set -gx FLUTTER_STORAGE_BASE_URL "https://storage.flutter-io.cn"
# set -gx PUB_HOSTED_URL "https://pub.flutter-io.cn"
# fish_add_path $FLUTTER_HOME/bin

# emscripten
# set -gx EMSDK $HOME/Work/emsdk
# fish_add_path $EMSDK
# set -gx EM_CONFIG $REMSDK/.emscripten
