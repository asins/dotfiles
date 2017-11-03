# 别名
source ~/.config/fish/aliases.fish

set -gx EDITOR vim

# fzf 全局文件查找 使用ag工具
set -x FZF_DEFAULT_COMMAND 'ag -l -g ""'
set -x FZF_DEFAULT_OPTS '--color fg:188,bg:233,hl:103,fg+:222,bg+:234,hl+:104
--color info:183,prompt:110,spinner:107,pointer:167,marker:215'

if status --is-login
	source ~/.config/fish/env.fish
end
