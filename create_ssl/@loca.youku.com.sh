#!/bin/bash

# 生成本地证书
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout local.youku.com.key -out local.youku.com.crt -config local.youku.com.conf
