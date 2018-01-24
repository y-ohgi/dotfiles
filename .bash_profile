source ~/.bashrc
if [ -f ~/.bash_profile_cmp -o -L ~/.bash_profile_cmp ]; then
    source ~/.bash_profile_cmp
fi

alias f='open .'
alias j='z'

alias g='git'
alias d='docker'
alias fig='docker-compose'
alias pbcopy="nkf -w | __CF_USER_TEXT_ENCODING=0x$(printf %x $(id -u)):0x08000100:14 pbcopy"
alias redis="/usr/local/bin/redis-server &"
alias fuck='eval "$(thefuck --alias)"'

# mkcd だとエラーを吐かれる
mkdc() {
    mkdir -p -- "$1" &&
      cd -P -- "$1"
}

cdf() {
    target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
    if [ "$target" != "" ]; then
        cd "$target"; pwd
    else
        echo 'No Finder window found' >&2
    fi
}

# docker run -it ${image} bash の短縮形
db() {
    docker run -it $@ bash
}

export PATH=$PATH:$HOME/.rbenv/bin
eval "$(rbenv init -)"

# export PYENV_ROOT="${HOME}/.pyenv"
# export PATH=${PYENV_ROOT}/bin:$PATH
# eval "$(pyenv init -)"

. `brew --prefix`/etc/profile.d/z.sh

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export GO15VENDOREXPERIMENT=1

export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

PATH=".composer/vendor/bin/:$PATH"

eval "$(direnv hook bash)"
alias direnv="EDITOR=vi direnv"

#export PHPBREW_SET_PROMPT=1
source ~/.phpbrew/bashrc
