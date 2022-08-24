# 此文件仅在登录shell时执行（负责设置初始环境）。
set -gx PATH /bin
set -gx PATH /sbin $PATH
set -gx PATH /usr/bin $PATH
set -gx PATH /usr/sbin $PATH
set -gx PATH ~/.bin $PATH
set -gx PATH /usr/local/sbin $PATH
set -gx PATH /usr/local/bin $PATH
set -gx PATH ~/.deno/bin $PATH

# brew源改为阿里云
# set -gx HOMEBREW_BOTTLE_DOMAIN https://mirrors.aliyun.com/homebrew/homebrew-bottles
set -gx HOMEBREW_BOTTLE_DOMAIN https://mirrors.ustc.edu.cn/homebrew-bottles

# java运行环境变量
# set -gx JAVA_HOME (/usr/libexec/java_home -F)
# set -gx M2_HOME "/usr/local/opt/maven/libexec"
# set -g fish_user_paths "/usr/local/opt/openjdk/bin" $fish_user_paths
# set -gx CPPFLAGS "-I/usr/local/opt/openjdk/include"

# java旧版
# set -gx TOMCAT_HOME "/usr/local/opt/tomcat@7/libexec"
# set -gx PATH $PATH $TOMCAT_HOME/bin
#set -gx PATH $PATH $M2_HOME/bin

set -g fish_user_paths "/usr/local/opt/ruby/bin" $fish_user_paths

# Rust
set -gx PATH $PATH $HOME/.cargo/bin
# set -gx RUST_SRC_PATH "/usr/local/opt/rust"
set -gx PKG_CONFIG_PATH $PKG_CONFIG_PATH "/usr/local/opt/icu4c/lib/pkgconfig"

# openssl
set -g fish_user_paths "/usr/local/opt/curl/bin" $fish_user_paths
set -gx LDFLAGS "-L/usr/local/opt/curl/lib"
set -gx CPPFLAGS "-I/usr/local/opt/curl/include"
set -gx PKG_CONFIG_PATH $PKG_CONFIG_PATH  "/usr/local/opt/curl/lib/pkgconfig"

# Android开发: adb命令
set -gx ANDROID_HOME "~/Library/Android/sdk"
set -gx PATH $PATH $ANDROID_HOME/tools
set -gx PATH $PATH $ANDROID_HOME/platform-tools

# Flutter镜像
set -gx FLUTTER_HOME $HOME/work/ali-lutter
set -gx FLUTTER_STORAGE_BASE_URL "https://storage.flutter-io.cn"
set -gx PUB_HOSTED_URL "https://pub.flutter-io.cn"
# set -gx PUB_HOSTED_URL "https://pub.alibaba-inc.com"
# set -gx FLUTTER_STORAGE_BASE_URL "https://storage.flutter-io.cn"
set -gx FLUTTER_STORAGE_BASE_URL "http://flutter-storage.alibaba-inc.com/taobao"

set -gx PATH $PATH $FLUTTER_HOME/bin

# emscripten
# set -gx EMSDK $HOME/Work/emsdk
# set -gx PATH $PATH $EMSDK
# set -gx EM_CONFIG $REMSDK/.emscripten

# node的包管理器: pnpm
set -gx PNPM_HOME "/Users/asins/Library/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
