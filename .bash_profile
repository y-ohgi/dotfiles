# brew --prefix が地味に遅いので変数へ退避
BREW_PREFIX=$(brew --prefix)
GHQ_ROOT_PATH=$(ghq root)

. ~/.bashrc
[[ -s ~/.bash_profile_cmp ]] && . ~/.bash_profile_cmp
. ${BREW_PREFIX}/etc/profile.d/z.sh
. ${BREW_PREFIX}/etc/bash_completion
.  /usr/local/opt/kube-ps1/share/kube-ps1.sh

if [ -e `ghq list --full-path | grep enhancd | head -n 1`  ]; then
    . $GHQ_ROOT_PATH/$(ghq list | grep enhancd | head -n 1)/init.sh
fi


export "PATH=$PATH:/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin/"

if [[ "${TMUX}" != "" ]]; then
    export EDITOR=emacsclient
fi


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


p() {
    case "$1" in
        ghq)
            builtin cd $(ghq root)/$(ghq list | fzf) ;;
        git-checkout)
            local tags branches target

            git status &> /dev/null || return

            tags=$(git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || ''
            branches=$(
                git branch --all | grep -v HEAD             |
                    sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
                    sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || ''
            target=$(
                (echo "$tags"; echo "$branches") |
                    fzf-tmux -l30 -- --no-hscroll --ansi +m -d "\t" -n 2) || return

            git checkout $(echo "$target" | awk '{print $2}');;

        git-checkout-remote)
            local branches branch
            branches=$(git branch --all | grep -v HEAD) &&
                branches==$(echo "$branches" | fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
                git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##") ;;

    esac
}
_p() {
    local cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $(compgen -W "ghq git-checkout git-checkout-remote" -- $cur) )
}
complete -F _p p


####################
# key bind
peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    local l=$(\history | awk '{$1="";print}' | eval $tac | peco | cut -d' ' -f4-)
    READLINE_LINE="${l}"
    READLINE_POINT=${#l}
}
# M-r
bind -x '"\er": peco-select-history'

# M-h
bind '"\eh": backward-kill-word'


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
