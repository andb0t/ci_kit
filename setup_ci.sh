#!/bin/bash

# define arguments
GIT_PROVIDER=""
if [ -z "$1" ]; then
  echo "No argument supplied! Chose one:"
  echo "GITLAB, GITHUB, AZUREDEVOPS, BITBUCKET"
  exit
else
  GIT_PROVIDER="$1"
fi

# get git directory
REP_ROOT=$(git rev-parse --show-toplevel)
KIT_ROOT="$( cd "$(dirname "$0")" || exit; pwd -P )"

# find out if it is submodule
REPO_DIFF="$(diff -q "$REP_ROOT" "$KIT_ROOT")"
if [[ -z "$REPO_DIFF" ]]; then
  IS_SUBMODULE="Y"
else
  IS_SUBMODULE="N"
fi

echo "REP_ROOT:     $REP_ROOT"
echo "KIT_ROOT:     $KIT_ROOT"
echo "IS_SUBMODULE: $IS_SUBMODULE"


# copy pipeline files
if [[ "$GIT_PROVIDER" == "GITLAB" ]]; then
  yml_file="gitlab-ci.yml"
  cp "$KIT_ROOT/$yml_file" "$REP_ROOT/.$yml_file"
  cp -r "$KIT_ROOT/ci_tests" "$REP_ROOT/.gitlab-ci.d"
else
  echo "Not implemented, yet! Please contribute!"
fi
