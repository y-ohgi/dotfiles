# emacs 風キーバインドにする
bindkey -e

# historyの設定
HISTFILE=~/.zsh_history

# ref: https://github.com/agkozak/zsh-z
source /opt/zsh-z/zsh-z.plugin.zsh

eval "$(mise activate zsh)"

export PATH="$PATH:$HOME/go/bin:/Users/y-ohgi/.local/bin"

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

# === keybinds
bindkey '^[h' backward-kill-word

_bindkey_blank() {
  echo "\n\n"
  zle reset-prompt
}
zle -N _bindkey_blank
bindkey '^J' _bindkey_blank

pipi() {
  python -m venv .venv
  source .venv/bin/activate

  pip install -r requirements.txt
}

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
  docker run -it --rm $@ which bash
  if [[ $? == "0" ]]; then
    docker run -it --rm $@ bash
  else
    docker run -it --rm $@ ash
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

    github-repo-create)
      gh repo create ;;

    gcloud-set-project)
      local project
      project=$(gcloud projects list --format=json | jq -r 'map(.projectId) | .[]' | fzf) || return
      gcloud config set project ${project} ;;

    aws-sso-login)
     local profile
     profile=$(aws configure list-profiles | fzf) || return
     aws sso login --profile ${profile} ;;

    claude-mcp-add-serena)
      claude mcp add serena -- uvx --from git+https://github.com/oraios/serena serena-mcp-server --context ide-assistant --project $(pwd) ;;

    env)
      set -a
      source .env
      if [ -f ".envrc" ]; then source .envrc; fi
      set +a ;;
  esac
}

_p() {
  local -a commands
  commands=(
    'ghq:description for ghq'
    'gcloud-set-project:description for gcloud-set-project'
    'aws-sso-login:description for aws-sso-login'
    'claude-mcp-add-serena:description for claude-mcp-add-serena'
    'env:description for env'
    'github-repo-create:description for github-repo-create'
    # 'k-exec-pod:description for k-exec-pod'
    # 'aws-change-profile:description for aws-change-profile'
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
        echo "$branch"
    fi
}

prompt_symbol() {
    if [ $UID -eq 0 ]; then
        echo "#"
    else
        echo "$"
    fi
}

PROMPT='%F{cyan}%~%f %F{green}$(git_branch)%f %(?,0,%F{red}%?%f)
$(prompt_symbol) '

# Work configs
if [ -f "$HOME/.zsh_work" ]; then
  . $HOME/.zsh_work
fi

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

# Browser-Use
export PATH="/Users/y-ohgi/.browser-use-env/bin:/Users/y-ohgi/.local/bin:$PATH"
