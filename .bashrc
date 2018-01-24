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

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /Users/ogi-yusuke/.nvm/versions/node/v6.11.3/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash ] && . /Users/ogi-yusuke/.nvm/versions/node/v6.11.3/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /Users/ogi-yusuke/.nvm/versions/node/v6.11.3/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash ] && . /Users/ogi-yusuke/.nvm/versions/node/v6.11.3/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash