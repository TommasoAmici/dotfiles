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
