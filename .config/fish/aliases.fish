#Quick edits
alias vim 'nvim -VA'

alias g 'git'
alias c clear

# maven构建
alias mvn-app 'mvn clean eclipse:eclipse install -DskipTests'

#ag
alias notes 'ag "TODO|HACK|FIXME|OPTIMIZE"'

# 创建目录
alias md 'mkdir -p'

function vaa
	set pattern $argv[1]
	if test (count $argv) -gt 1
		set argv $argv[2..-1]
	else
		set argv
	end

	set ag_pattern (echo $argv | sed -Ee 's/[<>]/\\\\b/g')
	set vim_pattern (echo $argv | sed -E -e 's,([/=]),\\\\\1,g' -e 's,.*,/\\\\v&,')
	ag -l --smart-case --null -a $ag_pattern -- $argv ^/dev/null | xargs -0 -o vim -c $vim_pattern
end
