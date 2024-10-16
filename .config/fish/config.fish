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

# 尝试加载公司内部配置
# if test -e ~/.config/fish/config-work.fish
# 	source ~/.config/fish/config-work.fish
# end

# fisher plugin tide setting
set tide_git_truncation_length = 42 # 显示完整分支名


# pnpm
set -gx PNPM_HOME "/Users/asins/Library/pnpm"
set -gx PATH "$PNPM_HOME" $PATH

# starShip: 超级快、支持各种订制的极简命令行提示符
starship init fish | source
