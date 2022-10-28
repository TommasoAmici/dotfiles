#!/bin/sh

# This index file appropriately loads all other files from the sh/ directory

DOTFILES="$HOME/dotfiles"

# shellcheck source=./aliases.sh
[ -f "$DOTFILES/sh/aliases.sh" ] && . "$DOTFILES/sh/aliases.sh"

# shellcheck source=./environment.sh
[ -f "$DOTFILES/sh/environment.sh" ] && . "$DOTFILES/sh/environment.sh"

# shellcheck source=./log.sh
[ -f "$DOTFILES/sh/log.sh" ] && . "$DOTFILES/sh/log.sh"

# shellcheck source=./env.sh
[ -f "$DOTFILES/sh/env.sh" ] && . "$DOTFILES/sh/env.sh"

# shellcheck source=./git.sh
[ -f "$DOTFILES/sh/git.sh" ] && . "$DOTFILES/sh/git.sh"

# shellcheck source=./utils.sh
[ -f "$DOTFILES/sh/utils.sh" ] && . "$DOTFILES/sh/utils.sh"

# shellcheck source=./images.sh
[ -f "$DOTFILES/sh/images.sh" ] && . "$DOTFILES/sh/images.sh"

# shellcheck source=./python.sh
[ -f "$DOTFILES/sh/python.sh" ] && . "$DOTFILES/sh/python.sh"

# shellcheck source=./semgrep.sh
[ -f "$DOTFILES/sh/semgrep.sh" ] && . "$DOTFILES/sh/semgrep.sh"

# shellcheck source=./tar.sh
[ -f "$DOTFILES/sh/tar.sh" ] && . "$DOTFILES/sh/tar.sh"

# shellcheck source=./twitter.sh
[ -f "$DOTFILES/sh/twitter.sh" ] && . "$DOTFILES/sh/twitter.sh"

if type ffmpeg >/dev/null 2>&1; then
  # shellcheck source=./ffmpeg.sh
  [ -f "$DOTFILES/sh/ffmpeg.sh" ] && . "$DOTFILES/sh/ffmpeg.sh"
fi

# shellcheck source=./secrets.sh
[ -f "$DOTFILES/secrets.sh" ] && . "$DOTFILES/sh/secrets.sh"

# haskell configuration
[ -f ~/.ghcup/env ] && . "$HOME/.ghcup/env"
