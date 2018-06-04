dotfiles
---

# local
```
$ brew install z direnv bash-completion stern kubectx kube-ps1 reattach-to-user-namespace ghq peco fzf extract_url tmux emacs-plus
$ ./dotfilesLink.sh
$ ghq get https://github.com/b4b4r07/enhancd
$ source ~/.ghq/github.com/b4b4r07/enhancd/init.sh
$ gvm install go1.4 -B
$ gvm use go1.4
$ export GOROOT_BOOTSTRAP=$GOROOT
$ gvm install go1.10.1
$ gvm use go1.10.1 --default
```

## one liner
```
$ xcode-select --install && \
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" && \
    brew tap d12frosted/emacs-plus && \
    brew install z direnv bash-completion stern kubectx kube-ps1 reattach-to-user-namespace ghq peco fzf extract_url tmux emacs-plus mercurial && \
    brew tap caskroom/fonts && \
    brew cask install font-source-code-pro && \
    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d && \
    bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
```

# gui
```
$ brew cask install google-japanese-ime alfred bettertouchtool docker inkdrop gyazo atom kitematic 
```

## Web Site
* WunderList
    - https://www.wunderlist.com/ja/download/
* Google Chrome
    - https://www.google.co.jp/chrome/

## AppStore
* 1password
* slack

# server
`.bashrc` と `.emacs.d/init.el.server` を読み込ませる
```
# curl https://y-ohgi.github.io/dotfiles/install.sh | sh
```
