alias ll='ls -lat'
alias grep="grep --color"
alias ..='cd ..'

HISTSIZE=50000
HISTTIMEFORMAT='%Y/%m/%d %H:%M:%S '

export CLICOLOR=1
if [ "$(uname)" = 'Darwin' ]; then
    export LSCOLORS=gxfxcxdxbxegedabagacad
fi
export LESSCHARSET=utf-8
export LC_CTYPE=ja_JP.UTF-8
export LANG=C.UTF-8
