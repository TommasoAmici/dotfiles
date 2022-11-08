#!/bin/sh

alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gss="git status"

gi() {
  _help() {
    echo "Query toptal.com to generate .gitignore files

USAGE:
  gi [OPTIONS] [LANGUAGES]

EXAMPLE USAGE:
  gi node,yarn,git,macos,visualstudiocode > .gitignore

ARGS:
  <LANGUAGES>  Comma separated list of programming languages, IDEs, OSs

OPTIONS:
  -h  Print help information
  -i  Run in interactive mode
"
  }

  BASE_API=https://www.toptal.com/developers/gitignore/api
  _list_options() {
    curl --silent "$BASE_API/list" | tr ',' '\n'
  }
  _make_gitignore() {
    curl --silent "$BASE_API/$1"
  }
  while getopts "hi" option; do
    case $option in
    i) GI_INTERACTIVE=1 ;;
    h | *) _help && return ;;
    esac
  done

  if [ -n "$GI_INTERACTIVE" ]; then
    if type fzf >/dev/null 2>&1; then
      GI_LIST=$(_list_options | fzf --multi | tr '\n' ',')
      _make_gitignore "$GI_LIST"
    else
      log_error "fzf not installed, cannot run gi in interactive mode"
    fi
  else
    GI_LIST=$1
    _make_gitignore "$GI_LIST"
  fi

  unset GI_INTERACTIVE
}

git_reset_one_file() {
  git checkout HEAD -- "$1"
}

# Performs maintenance of git repositories.
# Adapted from https://github.com/acifani/dotfiles/blob/master/utils/git-optimize
git_optimize() {
  [ -d .git ] || return 0

  log_info 'Verifies the connectivity and validity of the objects in the database'
  git fsck --full || { log_error 'Failed' && return 1; }

  log_info 'Manage reflog information'
  git reflog expire --expire=now --all || { log_error 'Failed' && return 2; }

  log_info 'Pack unpacked objects in a repository'
  git repack -a -d -l || { log_error 'Failed' && return 3; }

  log_info 'Cleanup unnecessary files and optimize the local repository and prune all unreachable objects from the object database'
  git gc --prune=now --aggressive || { log_error 'Failed' && return 4; }
}

# Runs git_optimize for all directories in the current directory.
git_optimize_all() {
  CURRENT_DIR=$(pwd)
  for dir in ./*/; do
    cd "$CURRENT_DIR" || return
    log_debug "Running git maintenance in $dir"
    cd "$dir" || return
    git_optimize && log_success "Successful git maintenance in $dir"
  done
  cd "$CURRENT_DIR" || return
}

# Sets core.fsmonitor and core.untrackedcache to true for all directories
# in the current directory.
# https://github.blog/2022-06-29-improve-git-monorepo-performance-with-a-file-system-monitor/
git_fsmonitor_all() {
  CURRENT_DIR=$(pwd)
  for dir in ./*/; do
    cd "$CURRENT_DIR" || return
    log_debug "Setting core.fsmonitor to true in $dir"
    cd "$dir" || return

    [ -d .git ] &&
      git config core.fsmonitor true &&
      git config core.untrackedcache true &&
      log_success "Set core.fsmonitor and core.untrackedcache to true $dir"
  done
  cd "$CURRENT_DIR" || return
}

# Returns the name of the default branch in the current repo
git_default_branch() {
  _SYMBOLIC_REF=$(git symbolic-ref refs/remotes/origin/HEAD)
  printf "%s" "${_SYMBOLIC_REF#refs/remotes/origin/}"
}
