#!/bin/sh

DOTFILES="$HOME/dotfiles"

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

_SQLITE_PATH="$(brew --prefix sqlite)/bin"
_LIBRESSL_PATH="$(brew --prefix libressl)/bin"
_CURL_PATH="$(brew --prefix curl)/bin"
_POSTGRES15_PATH="$(brew --prefix postgresql@15)/bin"
export PATH="$_SQLITE_PATH:$_LIBRESSL_PATH:$_CURL_PATH:$_POSTGRES15_PATH:$PATH"

export PATH=~/.rustup/toolchains/stable-aarch64-apple-darwin/bin:"$PATH"

export PNPM_HOME="$HOME/.pnpm"
export PATH="$PNPM_HOME:$PATH"

export ATUIN_CONFIG_DIR="$DOTFILES/atuin"

export BROWSER=none

export BAT_THEME=base16

# prevent eslint errors from showing error overlay in create-react-app
export ESLINT_NO_DEV_ERRORS=true
