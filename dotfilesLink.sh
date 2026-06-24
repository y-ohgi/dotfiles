#!/bin/sh

# files=(.bashrc .bash_profile .gitignore .gitconfig .gitignore_global .vimrc .spacemacs .tmux.conf .zshrc .scripts)
files=(.gitconfig .gitignore_global .vimrc .spacemacs .tmux.conf .zshrc)

for file in ${files[@]}; do
    echo $file

    ln -sf $PWD/$file ~/$file
done

git config --global core.excludesfile ~/.gitignore_global

source ~/.zshrc
