#!/bin/sh
#
# Author: Tommaso Amici
# This file contains utilities to print in different colors
#
# Reference colors:
# Black        0;30     Dark Gray     1;30
# Red          0;31     Light Red     1;31
# Green        0;32     Light Green   1;32
# Brown/Orange 0;33     Yellow        1;33
# Blue         0;34     Light Blue    1;34
# Purple       0;35     Light Purple  1;35
# Cyan         0;36     Light Cyan    1;36
# Light Gray   0;37     White         1;37

# Prints in red. Usage: log_error "hello world"
log_error() {
  printf "\033[1;31m%s\033[0m\n" "$1"
}

# Prints in green. Usage: log_success "hello world"
log_success() {
  printf "\033[1;32m%s\033[0m\n" "$1"
}
