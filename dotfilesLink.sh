#!/bin/sh

files=(.bash_profile .gitignore .gitconfig .gitignore_global .vimrc .emacs.d .tmux.conf .tmux_themes)

for file in ${files[@]}; do
    echo $file
    
    if test -e ~/$file; then
	unlink ~/$file
    fi

    ln -sf ~/dotfiles/$file ~/$file
done

source ~/.bash_profile

git config --global core.excludesfile ~/.gitignore_global

