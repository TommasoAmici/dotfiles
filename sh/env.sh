#!/bin/sh
#
# Author: Tommaso Amici

# Loads environment variables from .env file in current directory
loadenv() {
  set -o allexport
  . "./.env"
  set +o allexport
}
