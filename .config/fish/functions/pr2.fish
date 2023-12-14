function pr2 --description '快速在Git仓库中提交代码审核 相当于 git push origin HEAD:refs/for/[分支名]'
  set -l branchName ''

  if test (count $argv) -ne 0
    set arg $argv[1]

    # 测试分支名是否有效
    set isValid (git show-ref --verify refs/heads/$arg 2>/dev/null)
    if test -n "$isValid" # 非空
      set branchName $arg
    end
  end

  if test -z "$branchName"
    set branchName (git branch 2>/dev/null | grep \* | sed 's/* //')
  end

  if test -z "$branchName"
    echo "未找到Git分支信息"
  else
    echo "[Runing Cli]: git push origin \"HEAD:refs/for/$branchName\""
    git push origin "HEAD:refs/for/$branchName"
  end
end
