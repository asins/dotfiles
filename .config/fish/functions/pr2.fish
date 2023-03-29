function pr2 --description '快速在Git仓库中提交代码审核 相当于 git push origin HEAD:refs/for/[分支名]'
  set git_cb (git branch 2>/dev/null | grep \* | sed 's/* //')

  if test -z "$git_cb"
    echo "未找到Git分支信息"
  else
    git push origin "HEAD:refs/for/$git_cb"
  end
end
