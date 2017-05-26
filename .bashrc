# - https://github.com/asins/dotfiles
# - asinsimple@gmail.com

alias ..='cd ..'
alias ...='cd ../..'
alias vim='mvim -v'
alias la='ls -alh'
alias ll='ls -lh'
alias vi='vim'
alias hc="history -c"
alias which='type -p'
alias k5='kill -9 %%'
alias gv='vim +GV +"autocmd BufWipeout <buffer> qall"'
ext() {
  local name=$(basename $(pwd))
  cd ..
  tar -cvzf "$name.tgz" --exclude .git --exclude target --exclude "*.log" "$name"
  cd -
  mv ../"$name".tgz .
}



gitzip() {
  git archive -o $(basename $PWD).zip HEAD
}

gittgz() {
  git archive -o $(basename $PWD).tgz HEAD
}

gitdiffb() {
  if [ $# -ne 2 ]; then
    echo two branch names required
    return
  fi
  git log --graph \
  --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' \
  --abbrev-commit --date=relative $1..$2
}

make-patch() {
  local name="$(git log --oneline HEAD^.. | awk '{print $2}')"
  git format-patch HEAD^.. --stdout > "$name.patch"
}

