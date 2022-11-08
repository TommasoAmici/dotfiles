#!/bin/sh

cd "$(dirname "$0")" || exit 1

_usage() {
  echo "A script to send messages using the telegram API.

It requires a BOT_TOKEN environment variable to be set. It can optionally be added to a
.env file in the same directory as this script

USAGE:
  telegram.sh <GROUP_ID> <MSG>

OPTIONS:
  -h  Print help information
"
}

while getopts 'h' c; do
  case $c in
  h | *) _usage && exit 0 ;;
  esac
done

ENV_FILE=".env"
if [ -f "./$ENV_FILE" ]; then
  set -o allexport
  . "./$ENV_FILE"
  set +o allexport
fi

GROUP_ID=$1
MESSAGE=$2

RED_BOLD="1;31"

print_color() {
  LEVEL=$1
  COLOR=$2
  MSG=$3
  if [ -z "$NO_COLOR" ]; then
    printf "\033[${COLOR}m%s\033[0m: %s\n" "$LEVEL" "$MSG"
  else
    printf "%s: %s\n" "$LEVEL" "$MSG"
  fi
}

# Prints in red. Usage: log_error "hello·world"
log_error() {
  print_color "ERROR" $RED_BOLD "$1" >&2
}

if [ -z "$BOT_TOKEN" ]; then
  log_error "BOT_TOKEN is not set"
fi

if [ -z "$GROUP_ID" ]; then
  log_error "GROUP_ID is not set"
fi

if [ -z "$MESSAGE" ]; then
  log_error "MESSAGE is not set"
fi

curl -s --data "text=$MESSAGE" --data "chat_id=$GROUP_ID" "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" >/dev/null
