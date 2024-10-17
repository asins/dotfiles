if [ -f ~/.bashrc ]; then
    . ~/.bashrc;
fi 
. "$HOME/.cargo/env"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
