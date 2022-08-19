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

  while getopts "hi" option; do
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
