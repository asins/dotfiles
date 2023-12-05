function prepend-to-path --description '将给定目录添加到系统PATH变量头部'
    set -l dir ''
    if test (count $argv) -ne 0
        set dir $argv[1]
    end

    if test -d $dir
        set dir (abspath $dir)

        # 如果路径已存在于PATH数组中，则将其至于头部。
        for i in (seq (count $PATH) 1)
            if test $PATH[$i] = $dir
                set -e PATH[$i]
            end
        end
        set PATH $dir $PATH
    else
        echo "Dir \"$dir\" does not exist?"
    end
end
