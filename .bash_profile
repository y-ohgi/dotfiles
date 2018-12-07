
. ~/.bashrc
[[ -s ~/.bash_profile_cmp ]] && . ~/.bash_profile_cmp

# brew --prefix が地味に遅いので変数へ退避
BREW_PREFIX=$(brew --prefix)
GHQ_ROOT_PATH=$(ghq root)

export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8

export PATH=$PATH:$GOPATH/bin:/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin/:$HOME/.scripts

export GOPATH=$HOME/.go
export FZF_DEFAULT_OPTS='--height 40% --reverse --border --ansi'

if [[ "${TMUX}" != "" ]]; then
  export EDITOR=emacsclient
fi

. ${BREW_PREFIX}/etc/profile.d/z.sh
.  /usr/local/opt/kube-ps1/share/kube-ps1.sh

#XXX: bashの起動が遅いのでコメントアウト。
# . ${BREW_PREFIX}/etc/bash_completion

# if [ -e `ghq list --full-path | grep enhancd | head -n 1`  ]; then
#   . $GHQ_ROOT_PATH/$(ghq list | grep enhancd | head -n 1)/init.sh
# fi


alias ..='builtin cd ..'

alias f='open .'
alias j='z'

alias g='git'
alias d='docker'
alias fig='docker-compose'

alias pbcopy="nkf -w | __CF_USER_TEXT_ENCODING=0x$(printf %x $(id -u)):0x08000100:14 pbcopy"

#XXX: PROMPTコマンドに仕込まれるせいでいちいち重いのでコメントアウト。 `_prompt_command` でどうにかするか別のツールを探す
# eval "$(direnv hook bash)"
# alias direnv="EDITOR=vi direnv"

alias emacs="emacs -nw"

mkcd() {
  mkdir -p -- "$1" &&
    builtin cd -P -- "$1"
}

cdf() {
  target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
  if [ "$target" != "" ]; then
    builtin cd "$target"; pwd
  else
    echo 'No Finder window found' >&2
  fi
}

db() {
  docker run -it $@ which bash
  if [[ $? == "0" ]]; then
    docker run -it $@ bash
  else
    docker run -it $@ ash
  fi
}
dbv() {
  db -v `pwd`:/share $@
}


export IS_KUBE_PS1_ENABLED=false # kube_ps1の有効状態
k() {
  # bashの起動速度を上げるため、kubectlを使用する際に有効化させる
  if [[ "${IS_KUBE_PS1_ENABLED}" == false ]]; then
    IS_KUBE_PS1_ENABLED=true

    source <(stern --completion=bash) # たぶん効いてない
    source <(kubectl completion bash)
  fi

  kubectl $@
}

export GO_VERSION=1.10.1
export GOROOT=~/.gvm/gos/go${GO_VERSION}
export GOPATH=~/.gvm/pkgsets/go${GO_VERSION}/global
export PATH="$GOPATH:$GOROOT:$PATH"
export IS_GVM_ENABLED=false # gvm を使うタイミングで読み込む。0.1msぐらいかかる。
gvm() {
  [ -s  ~/.gvm/scripts/gvm -o "${IS_GVM_ENABLED}" == false ] && IS_GVM_ENABLED=true && . ~/.gvm/scripts/gvm

  gvm $@
}


#TODO: "/p-scripts" を作成し、その中へ関数毎に格納する。格納したファイル名を元に補完&ファイルを実行
p() {
  case "$1" in
    # ghq リポジトリ一覧
    ghq)
      locale repo
      repo=$(ghq list | fzf) || return
      builtin cd $(ghq root)/$repo ;;

    # ghq 新規リポジトリ作成
    ghq-mkrepo)
      local repo

      [[ -z $2 ]] && return

      repo=$( ls -1 `ghq root` | fzf )

      mkdir -p $(ghq root)/${repo}/_local/$2 && builtin cd $_ && git init;;

    # git ブランチもしくはタグへチェックアウト
    #FIXME
    git-checkout)
      git branch  | grep -v HEAD | sed "s/.* //" | fzf | xargs -I{} git checkout {};;

      # local tags branches target

      # git status &> /dev/null || return

      # tags=$(git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || ''
      # branches=$(
      #   git branch --all | grep -v HEAD             |
      #     sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
      #     sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || ''
      # target=$(
      #   (echo "$tags"; echo "$branches") |
      # fzf-tmux -l30 -- --no-hscroll --ansi +m -d "\t" -n 2) || return

      # git checkout $(echo "$target" | awk '{print $2}');;

    # git リモートブランチへチェックアウト
    #FIXME
    git-checkout-remote)
      local branches branch
      branches=$(git branch --all | grep -v HEAD) &&
        branches==$(echo "$branches" | fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
        git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##") ;;

    gcloud-set-project)
      local project
      project=$(gcloud projects list --format=json | jq -r 'map(.name) | .[]' | fzf) || return
      gcloud config set project ${project} ;;

    # kubernetesのpodへコマンドを送り込む
    k-exec-pod)
      local pod
      kubectl get pod | tail -n +2 | awk '{print $1}' | fzf -m | xargs -I{} kubectl exec -it {} ${@:2} ;;
  esac
}
_p() {
  local cur=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( $(compgen -W "ghq ghq-mkrepo git-checkout git-checkout-remote gcloud-set-project k-exec-pod" -- $cur) )
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
Green="\[\033[0;32m\]"
Blue="\[\033[0;34m\]"
Color_Off="\[\033[0m\]"

PROMPT_COMMAND="_prompt_command;${PROMPT_COMMAND}"
#PROMPT_COMMAND="_prompt_command;${PROMPT_COMMAND%*;u*}" #TODO: いい感じの正規表現か使いたい関数をベタ打ちするかする
_prompt_command() {
  LAST_EXEC="$?"
  PS1=""

  [[ ${IS_KUBE_PS1_ENABLED} == true && "${TMUX}" == "" ]] && PS1+=$(kube_ps1)

  PS1+="\w "
  PS1+="${Green}\$(_git_branch)${Color_Off} "
  PS1+="${Blue}\$(_gcp_project)${Color_Off} "
  PS1+="\$(_last_result) "
  PS1+="\n"
  PS1+="$ "
}


_git_branch() {
  GIT_BRANCH_NAME=$(git branch 2>/dev/null | sed -ne "s/^\* \(.*\)$/\1/p")
  [[ "${GIT_BRANCH_NAME}" != "" ]] && echo -n "${GIT_BRANCH_NAME}" && echo " :$(git config user.name)"
}

_gcp_project() {
  [[ -e ~/.config/gcloud ]] || return
  echo "gcp: $(cat ~/.config/gcloud/configurations/config_default | grep project | sed -E 's/^\project = (.*)$/\1/')"
}

_last_result() {
  [[ ${LAST_EXEC:-0} != "0" ]] && echo "❌ "
}
