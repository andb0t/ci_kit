#!/bin/bash

SPAWNED_BY_GIT="$1"  # need explicit pass because Windows doesn't pass env when spawning bash

if [[ -z $SPAWNED_BY_GIT ]]; then
  # all files in repo (except certain directories)
  files=$(find . -type f ! -path "./.git/*" -exec ls "{}" ";")
else
  # cached files with relevant status code
  files=$(git diff --cached --name-status | grep -v '^D' | awk '{print $NF}')
fi

# Fail if trying to commit executed jupyter notebook
cached=()

# now check all files with relevant status code
files=$(git diff --cached --name-status | grep -v '^D' | awk '{print $NF}')
# now filter for ipynb files
files=$(echo "${files[@]}" | grep '.*.ipynb')
for file in $files
do
  finding=$(grep -e '\"execution_count\": [0-9][0-9]*' "$file")
  if [ "$finding" != "" ]; then
    cached+=("$file")
  fi
done

if [ ${#cached[@]} -eq 0 ]; then
  if [[ ! -z $VERBOSE_GITHOOKS ]]; then
    echo "[CONTENT] Jupyter notebook test passed"
  fi
else
  printf "[CONTENT] Error: Please clear the output of the jupyter notebook before committing:\\n%s\\n" "$files"
  exit 1
fi
