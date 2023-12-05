# 使用介绍(原npm版本: v0.0.1)
#   npm-version beta  --> npm version prerelease --preid beta  ==> Output: v0.0.1-beta.0
#   npm-version alpha --> npm version prerelease --preid alpha ==> Output: v0.0.1-alpha.0
#   npm-version patch --> npm version patch ==> Output v0.0.2
#   npm-version minor --> npm version minor ==> Output v0.1.0
#   npm-version major --> npm version major ==> Output v1.0.0
function npm-version --description 'npm更新版本号时自动执行git commit'
  set -l npm_version_what_list 'major' 'minor' 'patch' 'premajor' 'preminor' 'prepatch' 'prerelease' 'from-git'

  set -l what 'beta'
  if test (count $argv) -ne 0
    set what $argv[1]
  end

  # 指定执行命令
  set -l cliStr ''
  if contains $what $npm_version_what_list
    # npm version 原生命令
    set cliStr "npm version $what --no-git-tag-version"
  else if test $what = 'beta'
    # npm version prerelease --preid beta
    set cliStr "npm version prerelease --preid beta --no-git-tag-version"
  else if test $what = 'alpha'
    # npm version prerelease --preid alpha
    set cliStr "npm version prerelease --preid alpha --no-git-tag-version"
  else if test $what
    # npm version $newversion
    set cliStr "npm version $what --no-git-tag-version"
  end

  # 执行结果
  echo "[Runing Cli]: $cliStr"
  set -l msg (eval $cliStr 2>/dev/null)
  if test -z "$msg"
    echo "[错误]: 请进入Node项目目录后再执行"
  else
    echo "[Runing Cli]: git commit -am \"$msg\""
    git commit -am "$msg"
  end

end

