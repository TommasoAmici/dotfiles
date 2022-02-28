#!/bin/sh

# Performs maintenance of git repositories.
# Adapted from https://github.com/acifani/dotfiles/blob/master/utils/git-optimize
git_optimize() {
  log_info 'Verifies the connectivity and validity of the objects in the database'
  git fsck --full || { log_error 'Failed' && return 1; }

  log_info 'Manage reflog information'
  git reflog expire --expire=now --all || { log_error 'Failed' && return 2; }

  log_info 'Pack unpacked objects in a repository'
  git repack -a -d -l || { log_error 'Failed' && return 3; }

  log_info 'Cleanup unnecessary files and optimize the local repository and prune all unreachable objects from the object database'
  git gc --prune=now --aggressive || { log_error 'Failed' && return 4; }
}
