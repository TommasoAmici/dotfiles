#!/bin/sh
# A script to find JIRA tickets that were marked as done, but not merged to master/main
if type jira >/dev/null 2>&1; then
  printf "You need to install go-jira first: https://github.com/go-jira/jira\n"
fi

git_default_branch() {
  _SYMBOLIC_REF=$(git symbolic-ref refs/remotes/origin/HEAD)
  printf "%s" "${_SYMBOLIC_REF#refs/remotes/origin/}"
}

_DEFAULT_BRANCH=$(git_default_branch)

ISSUES=$(jira issue list --plain -sDone --columns KEY --no-headers)
for ISSUE in $ISSUES; do
  if ! git log --first-parent "$_DEFAULT_BRANCH" | grep "$ISSUE" >/dev/null; then
    printf "%s marked as done, but not merged on %s\n" "$ISSUE" "$_DEFAULT_BRANCH"
  fi
done
