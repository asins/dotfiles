#!/bin/bash

realpath() {
    path=`eval echo "$1"`
    folder=$(dirname "$path")
    echo $(cd "$folder"; pwd)/$(basename "$path");
}

abs_path () {
   echo "$(cd $(dirname "$1");pwd)/$(basename "$1")"
}

function normpath() {
  # Remove all /./ sequences.
  local path=${1//\/.\//\/}

  # Remove dir/.. sequences.
  while [[ $path =~ ([^/][^/]*/\.\./) ]]; do
    path=${path/${BASH_REMATCH[0]}/}
  done
  echo $path
}

target=$(realpath "~/test")

echo $target

if [ -L "${target}" ]; then # 存在的是软链接
  echo '软链接存在'
elif [ -f "${target}" ]; then # 真实文件存在
  echo '真实文件存在'
else
  echo '没检测出来'
fi
