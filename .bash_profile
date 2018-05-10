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

# mkcd だとエラーを吐かれる mkdc() {
mkcd() {
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
dbv() {
    docker run -it -v `pwd`:/tmp/shared $@ bash
}

. `brew --prefix`/etc/profile.d/z.sh

eval "$(direnv hook bash)"
alias direnv="EDITOR=vi direnv"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/ogi-yusuke/.sdkman"
[[ -s "/Users/ogi-yusuke/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/ogi-yusuke/.sdkman/bin/sdkman-init.sh"

export "PATH=$PATH:/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin/"


. $(brew --prefix)/etc/bash_completion
source <(stern --completion=bash)
source <(kubectl completion bash)

PS1="[\W]\$ "

kubeps1() {
    source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
    PS1='[\W $(kube_ps1)]\$ '
}
