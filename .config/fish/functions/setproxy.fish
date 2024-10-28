# 指定命令的代理
#   setproxy all # 设置所有命令的代理
#   setproxy npm
#   setproxy pnpm
function setproxy --description "设置代理 支持 http https git命令代理"

  set -l what 'all' # 对什么命令设置代理,默认为全局设置代理
  if test (count $argv) -ne 0
    set what $argv[1]
  end


  # 设置工作目录
  set workspace_dir "$HOME/WorkSpaces"

  # 获取当前执行命令时的目录
  set current_dir (pwd)

  # 使用privoxy来将http/https的请求转发给socks5协议:
  # vim /usr/local/etc/privoxy/config
  # 设置 privoxy 监听任意 ip 的 8118 端口
  # listen-address 0.0.0.0:8118
  # 设置转发到本地的 socks5 代理客户端端口
  # forward-socks5t / 127.0.0.1:7890 .

  # 使用v2pay时可不启用privoxy
  # brew services restart privoxy

  set socksUri socks://127.0.0.1:7890
  set socks5Uri socks5://127.0.0.1:7890
  set httpUri http://127.0.0.1:7890

  if test "$what" = 'all'
    echo "设置全局系统代理为$httpUri"
    set -Ux no_proxy localhost,127.0.0.1
    set -Ux all_proxy $httpUri
    set -Ux http_proxy $httpUri
    set -Ux https_proxy $httpUri
  end

  # git
  # 检查 what 的值是否是 'all' 或 'npm'，并且检查 npm 命令能否正常调用
  if test "$what" = 'all' -o "$what" = 'git' -a (command -v git)
    echo "设置 git 代理为$httpUri"
    git config --global socks.proxy $socksUri
    git config --global https.proxy $httpUri
    git config --global http.proxy $httpUri
  end

  # npm
  #npm config set proxy $httpUri
  #npm config set https-proxy $httpUri

  # 如果是工作空间下的文件夹则不设置
  if test "$what" = 'all' -o "$what" = 'npm' -a (command -v npm)
    if not string match -q -r "^$workspace_dir(/|\$)" "$current_dir"
      echo "设置 npm 代理为registry.npmmirror.com"
      npm config set registry https://registry.npmmirror.com
    else
       npm config set registry https://registry.npmjs.org
    end
  end

  if test "$what" = 'all' -o "$what" = 'pnpm' -a (command -v pnpm)
    # 如果是工作空间下的文件夹则不设置
    # if not string match -q -r "^$workspace_dir(/|\$)" "$current_dir"
      echo "设置 pnpm 代理为registry.npmmirror.com"
      pnpm config set registry https://registry.npmmirror.com
    # else
      # npm config set registry https://registry.npmjs.org/
    # end
  end

end
