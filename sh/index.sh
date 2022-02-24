#!/bin/sh

# This index file appropriately loads all other files from the sh/ directory

# shellcheck source=./sh/colors.sh
[ -f ~/dotfiles/sh/colors.sh ] && . ~/dotfiles/sh/colors.sh

# shellcheck source=./sh/random.sh
[ -f ~/dotfiles/sh/random.sh ] && . ~/dotfiles/sh/random.sh

# shellcheck source=./sh/images.sh
[ -f ~/dotfiles/sh/images.sh ] && . ~/dotfiles/sh/images.sh

if type ffmpeg >/dev/null 2>&1; then
  # shellcheck source=./sh/ffmpeg.sh
  [ -f ~/dotfiles/sh/ffmpeg.sh ] && . ~/dotfiles/sh/ffmpeg.sh
fi
