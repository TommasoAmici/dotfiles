#!/bin/zsh

DOTFILES="$HOME/dotfiles"

# increase size of history
HISTSIZE=99999
HISTFILESIZE=99999
SAVEHIST=$HISTSIZE

# prevent duplicates from being stored in history
# https://unix.stackexchange.com/a/625366
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY
HISTFILE="$HOME/.zsh_history"

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  zsh-syntax-highlighting
  yarn-autocompletions
)

FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

source $ZSH/oh-my-zsh.sh

# zoxide and fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if type zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh --cmd cd)"
fi

[ -f "$DOTFILES/sh/index.sh" ] && . "$DOTFILES/sh/index.sh"

# opam configuration
[ -f ~/.opam/opam-init/init.zsh ] && source ~/.opam/opam-init/init.zsh

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

# The next line enables shell command completion for gcloud.
if [ -f "$GCP_HOME/completion.zsh.inc" ]; then
  . "$GCP_HOME/completion.zsh.inc"
fi

if type oh-my-posh >/dev/null 2>&1; then
  eval "$(oh-my-posh init zsh --config $DOTFILES/powerlevel10k.omp.json)"
fi

if type atuin >/dev/null 2>&1; then
  export ATUIN_NOBIND="true"
  eval "$(atuin init zsh)"
  bindkey '^r' _atuin_search_widget
fi

if type rtx >/dev/null 2>&1; then
  eval "$(rtx activate zsh)"
fi

