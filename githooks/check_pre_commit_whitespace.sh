#!/bin/bash
SPAWNED_BY_GIT="$1"  # need explicit pass because Windows doesn't pass env when spawning bash

if [[ -z $SPAWNED_BY_GIT ]]; then
  # all files in repo (except certain directories)
  files=$(find . -type f  ! -path "./.git/*" -exec egrep -l " +$" {} \;)
else
  # Fail if trying to commit files with trailing whitespace, inconsistent indentation or merge markers
  files=$(git diff-index --check --cached HEAD --)
fi

if [[ -z $files ]]; then
  if [[ -n $VERBOSE_GITHOOKS ]]; then
    echo "[POLICY] Trailing whitespace test passed"
  fi
else
  printf "[POLICY] Error: Please clear the files of trailing whitespace before committing:\\n%s\\n" "$files"
  exit 1
fi
