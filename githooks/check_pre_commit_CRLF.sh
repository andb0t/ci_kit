#!/bin/bash

SPAWNED_BY_GIT="$1"  # need explicit pass because Windows doesn't pass env when spawning bash

if [[ -z $SPAWNED_BY_GIT ]]; then
  # all files in repo (except certain directories)
  files=$(find . -type f ! -path "./.git/*" -exec ls "{}" ";")
else
  # cached files with relevant status code
  files=$(git diff --cached --name-status | grep -v '^D' | grep -v '.pdf' | grep -v '.drawio' | awk '{print $NF}')
fi

# Fail if trying to commit files with CRLF line ending
cached=()
for file in $files
do
  found=$(grep -c $'\r' "$file")
  if [ "$found" != "0" ]; then
    cached+=("$file : $found lines")
  fi
done

if [ ${#cached[@]} -eq 0 ]; then
  if [[ -n $VERBOSE_GITHOOKS ]]; then
    echo "[POLICY] CRLF check passed"
  fi
else
  echo "[POLICY] Error: Please make sure to use POSIX line endings, LF instead of CRLF:"
  for file in "${cached[@]}"
  do
    echo "$file"
  done
  exit 1
fi
