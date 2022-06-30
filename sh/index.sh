#!/bin/sh

# This index file appropriately loads all other files from the sh/ directory

# shellcheck source=./log.sh
[ -f ~/dotfiles/sh/log.sh ] && . ~/dotfiles/sh/log.sh

# shellcheck source=./env.sh
[ -f ~/dotfiles/sh/env.sh ] && . ~/dotfiles/sh/env.sh

# shellcheck source=./git.sh
[ -f ~/dotfiles/sh/git.sh ] && . ~/dotfiles/sh/git.sh

# shellcheck source=./random.sh
[ -f ~/dotfiles/sh/random.sh ] && . ~/dotfiles/sh/random.sh

# shellcheck source=./images.sh
[ -f ~/dotfiles/sh/images.sh ] && . ~/dotfiles/sh/images.sh

# shellcheck source=./python.sh
[ -f ~/dotfiles/sh/python.sh ] && . ~/dotfiles/sh/python.sh

# shellcheck source=./semgrep.sh
[ -f ~/dotfiles/sh/semgrep.sh ] && . ~/dotfiles/sh/semgrep.sh

if type ffmpeg >/dev/null 2>&1; then
  # shellcheck source=./ffmpeg.sh
  [ -f ~/dotfiles/sh/ffmpeg.sh ] && . ~/dotfiles/sh/ffmpeg.sh
fi
