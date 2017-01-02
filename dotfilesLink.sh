#!/bin/sh

files=(.bash_profile .gitignore .gitignore_global .vimrc .emacs.d)

for file in ${files[@]}; do
    echo $file
    
    if test -e ~/$file; then
	unlink ~/$file
    fi

    ln -sf ~/dotfiles/$file ~/$file
done

source ~/.bash_profile

git config --global core.excludesfile ~/.gitignore_global

