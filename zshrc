#!/bin/zsh

DOTFILES="$HOME/dotfiles"

# prevent duplicates from being stored in history
# https://unix.stackexchange.com/a/625366
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

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

export EDITOR='vim'

export GPG_TTY=$(tty)

# aliases
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
alias la='l -a'
alias lla='ll -a'

alias mycc="cc -std=c99 -Wall -pedantic -Werror"
alias m=make
alias mc="make clean"
alias mr="make run"
alias bs='browser-sync start -c bs-config.js'
alias youtube-dl=yt-dlp
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias firefox="/Applications/Firefox\ Developer\ Edition.app/Contents/MacOS/firefox"

function fixgpg() {
  killall gpg-agent && gpg-agent --daemon --homedir $HOME/.gnupg
}

export PROJECT_ENV=development

export PATH=~/go/bin:$PATH
export PATH=~/.cargo/bin:$PATH
#export PATH="/usr/local/opt/node@16/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/sqlite/bin:$PATH"
export PATH="/usr/local/opt/gnupg@2.2/bin:$PATH"

# zoxide and fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if type zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh --cmd cd)"
fi

export TEALDEER_CONFIG_DIR="$DOTFILES/tealdeer"
tldr() {
  /opt/homebrew/bin/tldr "$1" || /opt/homebrew/bin/tldr -p linux "$1"
}

# opam configuration
[ -f ~/.opam/opam-init/init.zsh ] && source ~/.opam/opam-init/init.zsh
# haskell configuration
[ -f ~/.ghcup/env ] && source ~/.ghcup/env # ghcup-env

[ -f ~/.secrets.sh ] && . ~/.secrets.sh
[ -f "$DOTFILES/sh/index.sh" ] && . "$DOTFILES/sh/index.sh"

if type oh-my-posh >/dev/null 2>&1; then
  eval "$(oh-my-posh init zsh --config $DOTFILES/powerlevel10k.omp.json)"
fi
export PATH="/usr/local/opt/libressl/bin:$PATH"

# pnpm
export PNPM_HOME="~/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true
