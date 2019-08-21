# 此文件仅在登录shell时执行（负责设置初始环境）。
set -gx PATH /usr/local/sbin $PATH
set -gx PATH /usr/local/bin $PATH
set -gx PATH /bin
set -gx PATH /sbin $PATH
set -gx PATH /usr/bin $PATH
set -gx PATH /usr/sbin $PATH
set -gx PATH ~/.bin $PATH
set -gx PATH /usr/local/opt/tomcat@7/bin $PATH

# brew源改为阿里云
# set -x HOMEBREW_BOTTLE_DOMAIN https://mirrors.aliyun.com/homebrew/homebrew-bottles

# java运行环境变量
set -gx JAVA_HOME "/usr/libexec/java_home"
set -gx M2_HOME "/usr/local/opt/maven/libexec"
# set -gx TOMCAT_HOME "/usr/local/opt/tomcat@7/libexec"
set -gx PATH $PATH $TOMCAT_HOME/bin
set -gx PATH $PATH $M2_HOME/bin

set -g fish_user_paths "/usr/local/opt/curl/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/ruby/bin" $fish_user_paths
