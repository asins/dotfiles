# 此文件仅在登录shell时执行（负责设置初始环境）。
set -gx PATH /bin
fish_add_path /sbin
fish_add_path /usr/bin
fish_add_path /usr/sbin
fish_add_path /opt/homebrew/bin
fish_add_path /usr/local/sbin
fish_add_path /usr/local/bin
fish_add_path ~/.bin

# brew源改为阿里云
# set -gx HOMEBREW_BOTTLE_DOMAIN https://mirrors.aliyun.com/homebrew/homebrew-bottles
set -gx HOMEBREW_BOTTLE_DOMAIN https://mirrors.ustc.edu.cn/homebrew-bottles

# java运行环境变量
# set -gx JAVA_HOME (/usr/libexec/java_home -F)
fish_add_path /opt/homebrew/opt/openjdk/bin
# set -gx M2_HOME "/usr/local/opt/maven/libexec"
set -gx CPPFLAGS "-I/opt/homebrew/opt/openjdk/include"

# java旧版
# set -gx TOMCAT_HOME "/usr/local/opt/tomcat@7/libexec"
# fish_add_path $TOMCAT_HOME/bin
# fish_add_path $M2_HOME/bin

fish_add_path /usr/local/opt/ruby/bin

# Rust
fish_add_path ~/.cargo/bin
# set -gx RUST_SRC_PATH "/usr/local/opt/rust"
set -gx PKG_CONFIG_PATH $PKG_CONFIG_PATH "/usr/local/opt/icu4c/lib/pkgconfig"

# openssl
fish_add_path /usr/local/opt/curl/bin
set -gx LDFLAGS "-L/usr/local/opt/curl/lib"
set -gx CPPFLAGS "-I/usr/local/opt/curl/include"
set -gx PKG_CONFIG_PATH $PKG_CONFIG_PATH  "/usr/local/opt/curl/lib/pkgconfig"

# Android开发: adb命令
set -gx ANDROID_HOME "~/Library/Android/sdk"
fish_add_path $ANDROID_HOME/tools
fish_add_path $ANDROID_HOME/platform-tools

# Flutter镜像
set -gx FLUTTER_STORAGE_BASE_URL "https://storage.flutter-io.cn"
set -gx PUB_HOSTED_URL "https://pub.flutter-io.cn"
fish_add_path $FLUTTER_HOME/bin

# emscripten
# set -gx EMSDK $HOME/Work/emsdk
# fish_add_path $EMSDK
# set -gx EM_CONFIG $REMSDK/.emscripten

# pnpm
set -gx PNPM_HOME "~/Library/pnpm"
fish_add_path $PNPM_HOME
