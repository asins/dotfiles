function pr2 --description '快速在Git仓库中提交代码审核 相当于 git push origin HEAD:refs/for/[分支名]'
  set __git_cb (git branch | grep \* | sed 's/* //')

  # printf "git push origin HEAD:/refs/for/$__git_cb"

  git push origin "HEAD:refs/for/$__git_cb"
end

