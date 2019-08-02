#!/bin/bash

SPAWNED_BY_GIT="$1"  # need explicit pass because Windows doesn't pass env when spawning bash

if [[ -z $SPAWNED_BY_GIT ]]; then
  # all files in repo (except certain directories)
  files=$(find . -type f ! -path "./.git/*" -exec ls "{}" ";")
else
  # cached files with relevant status code
  files=$(git diff --cached --name-status | grep -v '^D' | awk '{print $NF}')
fi

# define blacklist
BLACKLIST=(
           # fill this with words
           # "example_entry"
           )

# Fail if trying to commit files containing word from blacklist
cached=()
for file in $files
do
  for blackword in "${BLACKLIST[@]}"
  do
    found=$(grep -n "$blackword" "$file" | cut -d':' -f1)
    if [ -n "$found" ]; then
      cached+=("$file : $found: \"$blackword\"")
    fi
  done
done

if [ ${#cached[@]} -eq 0 ]; then
  if [[ -n $VERBOSE_GITHOOKS ]]; then
    echo "[POLICY] blacklist check passed"
  fi
else
  echo "[POLICY] Error: found terms from blacklist. Are you sure you want to commit this?"
  for file in "${cached[@]}"
  do
    echo "$file"
  done
  exit 1
fi
