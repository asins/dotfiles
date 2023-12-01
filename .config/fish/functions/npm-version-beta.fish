function npm-version-beta --description 'npm更新版本号时自动执行git commit'
  set msg (npm version prerelease --preid beta --no-git-tag-version 2>/dev/null)

  if test -z "$msg"
    echo "请进入Node项目目录后再执行"
  else
    git commit -am "$msg"
  end

end

