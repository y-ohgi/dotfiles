# brew --prefix が地味に遅いので変数へ退避
BREW_PREFIX=$(brew --prefix)

. ~/.bashrc
[[ -s ~/.bash_profile_cmp -o -L ~/.bash_profile_cmp ]] && .~/.bash_profile_cmp
. ${BREW_PREFIX}/etc/profile.d/z.sh
. ${BREW_PREFIX}/etc/bash_completion
.  /usr/local/opt/kube-ps1/share/kube-ps1.sh
[[ -s "~/.sdkman/bin/sdkman-init.sh" ]] && . ~/.sdkman/bin/sdkman-init.sh && export SDKMAN_DIR="/Users/ogi-yusuke/.sdkman"


export "PATH=$PATH:/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin/"


alias f='open .'
alias j='z'

alias g='git'
alias d='docker'
alias fig='docker-compose'

alias pbcopy="nkf -w | __CF_USER_TEXT_ENCODING=0x$(printf %x $(id -u)):0x08000100:14 pbcopy"

eval "$(direnv hook bash)"
alias direnv="EDITOR=vi direnv"


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

db() {
    docker run -it $@ bash
}
dbv() {
    docker run -it -v `pwd`:/tmp/shared $@ bash
}


####################
# Prompt
git_branch() {
    GIT_BRANCH_NAME=$(git branch 2>/dev/null | sed -ne "s/^\* \(.*\)$/\1/p")
    [[ "${GIT_BRANCH_NAME}" != "" ]] && echo "${GIT_BRANCH_NAME} "
}

gcp_project() {
    echo $(cat ~/.config/gcloud/configurations/config_default | grep project | sed -E 's/^\project = (.*)$/\1/')
}

kps1() {
    if [[ "${TMUX}" == "" ]]; then
        PS1="$(kube_ps1) \w \[\033[40;1;32m\]\$(git_branch)\[\033[0m\]\[\e[0;34mgcp:\$(gcp_project)\[\e[0m\] \n\$ "
    fi
}

export IS_KUBE_PS1_ENABLED=false
k() {
    if [[ "${IS_KUBE_PS1_ENABLED}" == false ]]; then
        IS_KUBE_PS1_ENABLED=true
        kps1
        source <(stern --completion=bash) # たぶん効いてない
        source <(kubectl completion bash)
    fi

    kubectl $@
}

PS1="\w \[\033[40;1;32m\]\$(git_branch)\[\033[0m\]\[\e[0;34mgcp:\$(gcp_project)\[\e[0m\] \n\$ "
