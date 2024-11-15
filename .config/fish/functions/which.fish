function which --description '更好的 `which`'
    if abbr --query $argv
        echo "$argv 是一个有定义的缩写"
        abbr --show | command grep "abbr -a -- $argv"
        type --all $argv 2>/dev/null
        return 0
    else
        type --all $argv
    end
end
