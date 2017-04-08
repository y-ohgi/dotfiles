#!/bin/sh

WORK_DIR=/tmp/dotfiles
GIT_URL=https://raw.githubusercontent.com/y-ohgi/dotfiles/master/

if [ -d WORK_DIR ]; then
    ls -lat WORK_DIR
    read -p "$WORK_DIR is exist dir. Are you sure you want to delete it? (y/n): " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
	rm -rf WORK_DIR
	echo "deleted."
    fi
fi

mkdir $WORK_DIR
cd $WORK_DIR

curl -O "${GIT_URL}.bashrc"
if [ -f /etc/bashrc ]; then
    /etc/bashrc >> .bashrc
fi
mv .bashrc /etc/bashrc
source /etc/bashrc

curl -O "${GIT_URL}.emacs.d/init.el.server"
mv init.el.server /usr/share/emacs/site-lisp/site-start.d/init.el
