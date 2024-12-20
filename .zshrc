# emacs 風キーバインドにする
bindkey -e

# historyの設定
HISTFILE=~/.zsh_history

export CLICOLOR=1

alias ll='ls -lat'

alias g='git'
alias d='docker'
alias m='make'
alias j='z'
alias t='terraform'
alias c='cursor'

alias rm='trash'
alias f='open .'

alias fig='docker compose'

alias emacs="emacs -nw"

# alias pbcopy="nkf -w | __CF_USER_TEXT_ENCODING=0x$(printf %x $(id -u)):0x08000100:14 pbcopy"

bindkey '^[h' backward-kill-word

eval "$(mise activate zsh)"

cursor() {
  open -a "/Applications/Cursor.app" "$@"
}

# cd
cdr() {
  cd $(git rev-parse --show-toplevel)
}

cdf() {
  target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
  if [ "$target" != "" ]; then
    cd "$target"; pwd
  else
    echo 'No Finder window found' >&2
  fi
}

# Docker
alias dbx='docker buildx build --load'

db() {
  docker run -it $@ which bash
  if [[ $? == "0" ]]; then
    docker run -it $@ bash
  else
    docker run -it $@ ash
  fi
}
dbv() {
  db -v `pwd`:/share:delegated -w /share $@
}
dbvh() {
  db -v `pwd`:/share:delegated -v $HOME:/root:delegated -w /share -u root $@
}

# Custom Commands
p() {
  case "$1" in
    ghq)
      local repo
      repo=$(ghq list | fzf) || return
      cd "$(ghq root)/$repo" ;;

    gcloud-set-project)
      local project
      project=$(gcloud projects list --format=json | jq -r 'map(.projectId) | .[]' | fzf) || return
      gcloud config set project ${project} ;;
  esac
}

_p() {
  local -a commands
  commands=(
    'ghq:description for ghq'
    'gcloud-set-project:description for gcloud-set-project'
    'k-exec-pod:description for k-exec-pod'
    'aws-change-profile:description for aws-change-profile'
  )

  _describe 'command' commands
}

autoload -Uz compinit && compinit
compdef _p p

# PROMPT
setopt PROMPT_SUBST

GREEN="%F{green}"
BLUE="%F{blue}"
YELLOW="%F{yellow}"
RESET="%f"

# Gitブランチを取得する関数
git_branch() {
    branch=$(git branch 2>/dev/null | sed -n '/^\*/s/^\* //p')
    if [ ! -z $branch ]; then
        echo "($branch)"
    fi
}

git_branch() {
    branch=$(git branch 2>/dev/null | sed -n '/^\*/s/^\* //p')
    if [ ! -z $branch ]; then
        echo "($branch) "
    fi
}

prompt_symbol() {
    if [ $UID -eq 0 ]; then
        echo "#"
    else
        echo "$"
    fi
}

PROMPT='%F{cyan}%~%f %F{green}$(git_branch)%f
$(prompt_symbol) '
