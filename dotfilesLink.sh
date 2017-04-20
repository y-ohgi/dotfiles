#!/bin/sh

files=(.bashrc .bash_profile .gitignore .gitconfig .gitignore_global .vimrc .emacs.d .tmux.conf .tmux_themes .zshrc)

for file in ${files[@]}; do
    echo $file

    ln -sf ~/dotfiles/$file ~/$file
done

source ~/.bash_profile

git config --global core.excludesfile ~/.gitignore_global

