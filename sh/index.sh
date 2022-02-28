#!/bin/sh

# This index file appropriately loads all other files from the sh/ directory

# shellcheck source=./sh/log.sh
[ -f ~/dotfiles/sh/log.sh ] && . ~/dotfiles/sh/log.sh

# shellcheck source=./sh/env.sh
[ -f ~/dotfiles/sh/env.sh ] && . ~/dotfiles/sh/env.sh

# shellcheck source=./sh/git.sh
[ -f ~/dotfiles/sh/git.sh ] && . ~/dotfiles/sh/git.sh

# shellcheck source=./sh/random.sh
[ -f ~/dotfiles/sh/random.sh ] && . ~/dotfiles/sh/random.sh

# shellcheck source=./sh/images.sh
[ -f ~/dotfiles/sh/images.sh ] && . ~/dotfiles/sh/images.sh

if type ffmpeg >/dev/null 2>&1; then
  # shellcheck source=./sh/ffmpeg.sh
  [ -f ~/dotfiles/sh/ffmpeg.sh ] && . ~/dotfiles/sh/ffmpeg.sh
fi
