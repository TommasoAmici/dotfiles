#!/bin/bash

DOTFILES="$HOME/dotfiles"

if type zoxide >/dev/null 2>&1; then
  eval "$(zoxide init bash --cmd cd)"
fi

[ -f "$DOTFILES/sh/index.sh" ] && . "$DOTFILES/sh/index.sh"

if type oh-my-posh >/dev/null 2>&1; then
  eval "$(oh-my-posh init bash --config "$DOTFILES/powerlevel10k.omp.json")"
fi
