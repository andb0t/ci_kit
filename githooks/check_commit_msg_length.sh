#!/bin/bash

message_file=$PWD"/.git/COMMIT_EDITMSG"
commit_msg=$(head -1 "${message_file:?Missing commit message file}")

# enforce maxium length
MAX_LEN=75
if [[ ${#commit_msg} -lt $MAX_LEN ]]; then
  if [[ ! -z $VERBOSE_GITHOOKS ]]; then
    echo "[POLICY] Maximum message length test passed"
  fi
else
  echo "[POLICY] Error: Please shorten your commit message (${#commit_msg} > $MAX_LEN)"
  exit 1
fi
