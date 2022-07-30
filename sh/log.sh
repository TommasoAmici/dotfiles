#!/bin/sh
#
# Author: Tommaso Amici
# This file contains utilities to print in different colors
#
# Colors:
# Black        0;30     Dark Gray     1;30
# Red          0;31     Light Red     1;31
# Green        0;32     Light Green   1;32
# Brown/Orange 0;33     Yellow        1;33
# Blue         0;34     Light Blue    1;34
# Purple       0;35     Light Purple  1;35
# Cyan         0;36     Light Cyan    1;36
# Light Gray   0;37     White         1;37
RED_BOLD="1;31"
GREEN_BOLD="1;32"
BLUE="0;34"
YELLOW="0;33"

# LEVELS
LOG_LEVEL_DEBUG=0
LOG_LEVEL_INFO=1
LOG_LEVEL_WARNING=2
export LOG_LEVEL=0

print_color() {
  COLOR=$1
  MSG=$2
  printf "\033[${COLOR}m%s\033[0m\n" "$MSG"
}

# Prints in red. Usage: log_error "hello world"
log_error() {
  print_color $RED_BOLD "$1"
}

# Prints debug information. Usage: log_debug "hello world"
log_debug() {
  if [ $LOG_LEVEL -le $LOG_LEVEL_DEBUG ]; then
    echo "$1"
  fi
}

# Prints in green, level info. Usage: log_success "hello world"
log_success() {
  if [ $LOG_LEVEL -le $LOG_LEVEL_INFO ]; then
    print_color $GREEN_BOLD "$1"
  fi
}

# Prints in blue. Usage: log_info "hello world"
log_info() {
  if [ $LOG_LEVEL -le $LOG_LEVEL_INFO ]; then
    print_color $BLUE "$1"
  fi
}

# Prints a warning in orange. Usage: log_warning "hello world"
log_warning() {
  if [ $LOG_LEVEL -le $LOG_LEVEL_WARNING ]; then
    print_color $YELLOW "$1"
  fi
}
