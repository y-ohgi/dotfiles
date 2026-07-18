#!/bin/zsh

# files=(.bashrc .bash_profile .gitignore .gitconfig .gitignore_global .vimrc .spacemacs .tmux.conf .zshrc .scripts)
files=(.gitconfig .gitignore_global .vimrc .spacemacs .tmux.conf .zshrc .config/ghostty/config)

for file in ${files[@]}; do
    echo $file

    # ~/.config 以下などネストしたディレクトリはデフォルトでは存在しないため、なければ作成する
    dir=$(dirname ~/$file)
    [ -d "$dir" ] || mkdir -p "$dir"

    ln -sf $PWD/$file ~/$file
done

git config --global core.excludesfile ~/.gitignore_global

source ~/.zshrc
