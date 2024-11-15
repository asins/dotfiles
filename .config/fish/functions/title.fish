function title --description '更改当前终端标题'
  if test (count $argv) -lt 1
    echo "请先指定要设置的标题"
    return 1
  end

  echo "function fish_title; echo \"$argv\"; end" | source -
end
