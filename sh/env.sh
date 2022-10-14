#!/bin/sh
#
# Author: Tommaso Amici

# Loads environment variables from .env file in current directory
loadenv() {
  _help() {
    echo "Loads environment variables from a file

USAGE:
  loadenv [ENV_FILE]

EXAMPLE USAGE:
  loadenv
  loadenv local.env

ARGS:
  <ENV_FILE> path to an env file, defaults to '.env'

OPTIONS:
  -h  Print help information
"
  }

  while getopts "h" option; do
    case $option in
    h | *) _help && return ;;
    esac
  done

  ENV_FILE="${1:-.env}"
  set -o allexport
  . "./$ENV_FILE"
  set +o allexport
}
