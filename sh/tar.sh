#!/bin/sh
#
# Author: Tommaso Amici
# This file contains helper functions to (de)compress with tar

# Compress and archive a directory using zstd
# https://github.com/facebook/zstd/issues/1526
tar_compress_dir_zstd() {
  OUT="${2:-$1}"
  tar --zstd -cf "$OUT.tar.zst" "$1/"
}

# Extract an archived directory compressed with zstd
tar_extract_dir_zstd() {
  FILE=$1

  [ -d "$FILE" ] && log_error "$FILE is a directory" && return

  if ! (echo "$FILE" | grep -q ".tar.zst"); then
    log_warning "Are you sure $FILE was archived and compressed with zstd? (y/n)"
    read -r answer
    # this grammar (the #[] operator) means that the variable $answer where any
    # Y or y in 1st position will be dropped if they exist.
    # https://stackoverflow.com/questions/226703/how-do-i-prompt-for-yes-no-cancel-input-in-a-linux-shell-script
    if [ "$answer" = "${answer#[Yy]}" ]; then
      return
    fi
  fi

  tar --zstd -xf "$FILE"
}
