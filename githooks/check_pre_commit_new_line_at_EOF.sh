#!/bin/bash

SPAWNED_BY_GIT="$1"  # need explicit pass because Windows doesn't pass env when spawning bash

if [[ -z $SPAWNED_BY_GIT ]]; then
  # all files in repo (except certain directories)
  files=$(find . -type f ! -path "./.git/*" -exec ls "{}" ";")
else
  # cached files with relevant status code
  files=$(git diff --cached --name-status | grep -v '^D' | grep -v '.pdf' | grep -v '.drawio' | awk '{print $NF}')
fi

# Fail if trying to commit files without newline at EOF
cached=()
for file in $files
do
  lastchar=$(tail -c 1 "$file")
  if [ "$lastchar" != "" ]; then
    cached+=("$file")
  fi
done

if [ ${#cached[@]} -eq 0 ]; then
  if [[ -n $VERBOSE_GITHOOKS ]]; then
    echo "[POLICY] Newline at end of file check passed"
  fi
else
  echo "[POLICY] Error: Please make sure to add a newline to the end of the files:"
  for file in "${cached[@]}"
  do
    echo "$file"
  done
  exit 1
fi
