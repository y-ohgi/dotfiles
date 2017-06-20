if [ -f ~/.bashrc -o -L ~/.bashrc ]; then
    . ~/.bashrc
fi

alias f='open .'
alias j='z'

alias fig='docker-compose'
alias pbcopy="nkf -w | __CF_USER_TEXT_ENCODING=0x$(printf %x $(id -u)):0x08000100:14 pbcopy"
alias redis="/usr/local/bin/redis-server &"
alias fuck='eval "$(thefuck --alias)"'

cdf() {
    target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
    if [ "$target" != "" ]; then
        cd "$target"; pwd
    else
        echo 'No Finder window found' >&2
    fi
}


export PATH=$PATH:$HOME/.rbenv/bin
eval "$(rbenv init -)"

export PYENV_ROOT="${HOME}/.pyenv"
export PATH=${PYENV_ROOT}/bin:$PATH
eval "$(pyenv init -)"

. `brew --prefix`/etc/profile.d/z.sh

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export GO15VENDOREXPERIMENT=1

#export PATH=$PATH:$HOME/.nodebrew/current/bin
export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

export PATH="/usr/local/terraform/bin:/home/$(whoami):$PATH"


source ~/.phpbrew/bashrc
