#!/bin/sh

alias c=clear

if type hx >/dev/null 2>&1; then
  alias vim=hx
fi

if type exa >/dev/null 2>&1; then
  alias ls="exa --classify --icons --grid"
  alias ll='exa --classify --icons --long'
  alias tree="exa --tree --icons"
else
  alias ls='ls -FG'
  alias ll='ls -lh'
fi
alias l="ls"
alias la="l -a"
alias lla="ll -a"

alias mycc="cc -std=c99 -Wall -pedantic -Werror"
alias m=make
alias mc="make clean"
alias mr="make run"
alias bs="browser-sync start -c bs-config.js"
alias youtube-dl=yt-dlp
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias firefox="/Applications/Firefox\ Developer\ Edition.app/Contents/MacOS/firefox"
