#!/bin/sh

unlink ~/.bash_profile
unlink ~/.gitconfig
unlink ~/.gitignore_global
unlink ~/.vimrc
unlink ~/.emacs.d

ln -sf ~/dotfiles/.bash_profile ~/.bash_profile

ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.gitignore_global ~/.gitignore_global
git config --global core.excludesfile ~/.gitignore_global

ln -sf ~/dotfiles/.vimrc ~/.vimrc

ln -sf ~/dotfiles/emacs.d ~/.emacs.d
