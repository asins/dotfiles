# This file is sourced on login shells only (responsible for setting up the
# initial environment)
set -gx PATH /bin
append-to-path /sbin
append-to-path /usr/bin
append-to-path /usr/sbin
append-to-path ~/bin
prepend-to-pat /usr/local/sbin
prepend-to-path /usr/local/bin

# java运行环境变量
set -gx JAVA_HOME "/Library/Java/JavaVirtualMachines/jdk1.7.0_80.jdk/Contents/Home"
set -gx M2_HOME "/usr/local/Cellar/maven/3.3.9/libexec"
set -gx TOMCAT_HOME "/usr/local/Cellar/tomcat7/7.0.70/libexec"
append-to-path $TOMCAT_HOME/bin
append-to-path $M2_HOME/bin
