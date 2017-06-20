alias ll='ls -lat'
alias grep="grep --color"
alias ..='cd ..'

HISTSIZE=50000
HISTTIMEFORMAT='%Y/%m/%d %H:%M:%S '

if [ "$(uname)" = 'Darwin' ]; then
    export LSCOLORS=gxfxcxdxbxegedabagacad
else
    export CLICOLOR=1
fi
export LESSCHARSET=utf-8
export LC_CTYPE=ja_JP.UTF-8
