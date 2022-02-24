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
