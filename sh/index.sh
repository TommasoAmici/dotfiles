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

# shellcheck source=./tar.sh
[ -f ~/dotfiles/sh/tar.sh ] && . ~/dotfiles/sh/tar.sh

# shellcheck source=./twitter.sh
[ -f ~/dotfiles/sh/twitter.sh ] && . ~/dotfiles/sh/twitter.sh

if type ffmpeg >/dev/null 2>&1; then
  # shellcheck source=./ffmpeg.sh
  [ -f ~/dotfiles/sh/ffmpeg.sh ] && . ~/dotfiles/sh/ffmpeg.sh
fi

# Find RSS feed from URL of YouTube channels
# Example usage:
#   yt_rss https://www.youtube.com/c/JoshuaWeissman
#   https://www.youtube.com/feeds/videos.xml?channel_id=UChBEbMKI1eCcejTtmI32UEw
yt_rss() {
  curl --silent "$1" | htmlq --attribute href "link[title='RSS']"
}
