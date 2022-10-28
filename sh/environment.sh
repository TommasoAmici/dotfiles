#!/bin/sh
# You may need to manually set your language environment
export LANG=en_US.UTF-8
# Setting for the new UTF-8 terminal support in Lion
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export EDITOR='vim'

GPG_TTY=$(tty)
export GPG_TTY

export PROJECT_ENV=development

export PATH=~/.local/bin":$PATH"
export PATH=~/dotfiles/scripts:"$PATH"
export PATH=~/go/bin:"$PATH"
export PATH=~/.cargo/bin:"$PATH"

_NODE_PATH="$(brew --prefix node@16)/bin:$PATH"
_SQLITE_PATH="$(brew --prefix sqlite)/bin:$PATH"
_LIBRESSL_PATH="$(brew --prefix libressl)/bin:$PATH"
_CURL_PATH="$(brew --prefix curl)/bin:$PATH"
_PYTHON311_PATH="$(brew --prefix python@3.11)/libexec/bin:$PATH"
_POSTGRES15_PATH="$(brew --prefix postgresql@15)/bin:$PATH"
export PATH="$_NODE_PATH:$_SQLITE_PATH:$_LIBRESSL_PATH:$_CURL_PATH:$_PYTHON311_PATH:$_POSTGRES15_PATH:$PATH"

export PATH=~/.rustup/toolchains/stable-aarch64-apple-darwin/bin:"$PATH"
