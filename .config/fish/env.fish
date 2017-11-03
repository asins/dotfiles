# 此文件仅在登录shell时执行（负责设置初始环境）。
set -gx PATH /bin 
set -gx PATH /sbin $PATH
set -gx PATH /usr/bin $PATH
set -gx PATH /usr/sbin $PATH
set -gx PATH /usr/local/sbin $PATH
set -gx PATH /usr/local/bin $PATH
set -gx PATH ~/.bin $PATH

# java运行环境变量
set -gx JAVA_HOME "/Library/Java/JavaVirtualMachines/jdk1.7.0_80.jdk/Contents/Home"
set -gx M2_HOME "/usr/local/opt/maven/libexec"
set -gx TOMCAT_HOME "/usr/local/opt/tomcat@7/libexec"
set -gx PATH $PATH $TOMCAT_HOME/bin
set -gx PATH $PATH $M2_HOME/bin
