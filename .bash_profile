#alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs -nw'
alias emacs="/usr/local/opt/emacs/Emacs.app/Contents/MacOS/Emacs -nw"
export CLICOLOR=1

#export PATH=$HOME/.nodebrew/current/bin:$PATH
#alias fuck='eval $(thefuck $(fc -ln -1))'
alias fuck='eval "$(thefuck --alias)"'

export PATH=$PATH:~/.composer/vendor/bin

alias ll='ls -lat'

#export PYENV_ROOT="${HOME}/.pyenv"
#export PATH=${PYENV_ROOT}/bin:$PATH
#eval "$(pyenv init -)"

#export PATH="$(brew --prefix homebrew/php/php70)/bin:$PATH"

export PATH=$HOME/.nodebrew/current/bin:$PATH

alias pbcopy="nkf -w | __CF_USER_TEXT_ENCODING=0x$(printf %x $(id -u)):0x08000100:14 pbcopy"

export LESSCHARSET=utf-8
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

export LC_CTYPE=ja_JP.UTF-8

HISTSIZE=50000
HISTTIMEFORMAT='%Y/%m/%d %H:%M:%S '

# start redis server
alias redis="/usr/local/bin/redis-server &"

# open current directory in Finder
alias f='open .'
# cd to the path of the front Finder window
cdf() {
    target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
    if [ "$target" != "" ]; then
        cd "$target"; pwd
    else
        echo 'No Finder window found' >&2
    fi
}

# z
# https://github.com/rupa/z
. `brew --prefix`/etc/profile.d/z.sh
alias j='z'

alias grep="grep --color"

export PYENV_ROOT="${HOME}/.pyenv"
export PATH=${PYENV_ROOT}/bin:$PATH
eval "$(pyenv init -)"

# go
if [ -x "`which go`" ]; then
    export GOROOT=`go env GOROOT`
    export GOPATH=$HOME/go
    export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
fi


