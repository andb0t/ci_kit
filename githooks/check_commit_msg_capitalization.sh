#!/bin/bash

message_file=$PWD"/.git/COMMIT_EDITMSG"
commit_msg=$(head -1 "${message_file:?Missing commit message file}")
regex_pattern='^(\[(\w+(\s+\w+)*)+\]\s)*[A-Z]+.*$'

# enforce start with capital letter or tag
if [[ $commit_msg =~ $regex_pattern ]]; then
  if [[ ! -z $VERBOSE_GITHOOKS ]]; then
    echo "[POLICY] Capital letter / tag test passed"
  fi
else
  echo "[POLICY] Error: Please start your commit message with a capital letter or [tag]"
  exit 1
fi
