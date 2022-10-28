#!/bin/sh
#
# Author: Tommaso Amici

# Generate a random alphanumeric sequence of length $1 (default=50).
# Usage: `secret_key [50]`
secret_key() {
  LENGTH="${1:-50}"
  base64 </dev/urandom | head -c "$LENGTH"
  printf "\n"
}

OPENSSL_FLAGS="-aes256 -salt -pbkdf2 -pass 'pass:${BACKUP_ENCRYPTION_KEY}'"
alias openssl_decrypt="openssl enc -d ${OPENSSL_FLAGS}"
alias openssl_encrypt="openssl enc -e ${OPENSSL_FLAGS}"

curl_cache() {
  PAGE=$(redis-cli GET "$1")
  if [ -z "$PAGE" ]; then
    curl --silent "$1" >_tmp
    redis-cli -x SET "$1" <_tmp >/dev/null
    redis-cli EXPIRE "$1" 86400 >/dev/null
    rm _tmp

    PAGE=$(redis-cli GET "$1")
  fi
  echo "$PAGE"
}

progress_bar() {
  _help() {
    echo "Print a progress bar, overwriting previous row.
To be used in loops to show progress.
Don't forget to print a newline at the end.

USAGE:
  progress_bar [CURRENT] [MAX]

EXAMPLE USAGE:
  progress_bar 85 100 [print newline here]

ARGS:
  <CURRENT> current progress step
  <MAX>     max number of steps

OPTIONS:
  -h  Print help information
"
  }

  while getopts "h" option; do
    case $option in
    h | *) _help && return ;;
    esac
  done

  CURRENT=$1
  TOTAL=$2
  COLS=$(tput cols)
  PAD=${#TOTAL}
  MAX_LENGTH=$((COLS - PAD - PAD - 5))
  PCT=$((CURRENT * MAX_LENGTH / TOTAL))
  BAR=$(printf "%${PCT}s" | tr " " "◼")
  TIP="▶"
  [ "$CURRENT" = "$TOTAL" ] && TIP=""
  printf "%${PAD}s/%s %s%s\r" "$CURRENT" "$TOTAL" "$BAR" "$TIP"
}

fixgpg() {
  killall gpg-agent && gpg-agent --daemon --homedir "$HOME/.gnupg"
}

# Find RSS feed from URL of YouTube channels
# Example usage:
#   yt_rss https://www.youtube.com/c/JoshuaWeissman
#   https://www.youtube.com/feeds/videos.xml?channel_id=UChBEbMKI1eCcejTtmI32UEw
yt_rss() {
  curl --silent "$1" | htmlq --attribute href "link[title='RSS']"
}

export TEALDEER_CONFIG_DIR="$DOTFILES/tealdeer"
tldr() {
  "$(brew --prefix)/bin/tldr" "$1" || "$(brew --prefix)/bin/tldr" -p linux "$1"
}
