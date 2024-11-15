# 别名
source ~/.config/fish/aliases.fish


if status --is-login
  source ~/.config/fish/env.fish
end


# 尝试加载公司内部配置
if test -e ~/.config/fish/config-work.fish
  source ~/.config/fish/config-work.fish
end


# starShip: 超级快、支持各种订制的极简命令行提示符
if [ -n (type -p starship) ]
  starship init fish | source
end

# zoxide: 更智能的 cd 命令(支持快速跳转)
if [ -n (type -p zoxide) ]
  zoxide init fish | source
end
