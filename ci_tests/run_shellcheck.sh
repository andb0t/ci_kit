#!/bin/bash

# find all files with shell extension
# shellcheck disable=SC2207
SHELL_SCRIPTS=($(find . ! -path "./.git/*" -name "*.sh" ))

# run shellcheck on all of them
FAILED=0
for file in "${SHELL_SCRIPTS[@]}"
do
  shellcheck "$file"
  status=$?
  if [[ "$status" != 0 ]]; then
    FAILED=1
  fi
done

if [[ "$FAILED" != 0 ]]; then
  echo "Please fix the above issues!"
  exit 1
fi
