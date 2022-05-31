#!/bin/zsh

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8
# Setting for the new UTF-8 terminal support in Lion
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='micro'
else
  export EDITOR='vim'
fi

export GPG_TTY=$(tty)

[ -f ~/.secrets.sh ] && . ~/.secrets.sh
[ -f ~/dotfiles/sh/index.sh ] && . ~/dotfiles/sh/index.sh
[ -f /usr/local/bin/trash ] && alias rm="/usr/local/bin/trash"

# aliases
alias c=clear

if type hx >/dev/null 2>&1; then
  alias vim=hx
fi

if type exa >/dev/null 2>&1; then
  alias ls="exa --classify --grid --icons"
  alias tree="exa --tree"
else
  alias ls='ls -FG'
fi
alias l=ls
alias ll='l -lh'
alias la='l -a'
alias lla='l -alh'

alias mycc="cc -std=c99 -Wall -pedantic -Werror"
alias m=make
alias mc="make clean"
alias mr="make run"
alias bs='browser-sync start -c bs-config.js'
alias youtube-dl=yt-dlp
function fixgpg() {killall gpg-agent && gpg-agent --daemon --homedir $HOME/.gnupg}

export PROJECT_ENV=development

export PATH=~/.nimble/bin:$PATH
export PATH=~/go/bin:$PATH
export PATH=~/.cargo/bin:$PATH
export PATH=~/Library/Python/3.9/bin:$PATH
# export PATH="/usr/local/opt/node@12/bin:$PATH"
# export PATH="/usr/local/opt/node@14/bin:$PATH"
export PATH="/usr/local/opt/node@16/bin:$PATH"
export PATH="/usr/local/Cellar/rsync/3.2.3/bin/:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/sqlite/bin:$PATH"
export PATH="/usr/local/opt/gnupg@2.2/bin:$PATH"

complete -o nospace -C /usr/local/bin/terraform terraform

# zoxide and fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if type zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh --cmd cd)"
fi

[ -f "~/.ghcup/env" ] && source "~/.ghcup/env" # ghcup-env

export TEALDEER_CONFIG_DIR=~/dotfiles/tealdeer

if type oh-my-posh >/dev/null 2>&1; then
  eval "$(oh-my-posh init zsh --config ~/dotfiles/powerlevel10k.omp.json)"
fi
