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
KIT_ROOT="$( cd "$(dirname "$0")" || exit; pwd -P )"/..
IS_SUBMODULE="$(diff -q "$REP_ROOT" "$KIT_ROOT")"

echo "REP_ROOT:     $REP_ROOT"
echo "KIT_ROOT:     $KIT_ROOT"
echo "IS_SUBMODULE: $IS_SUBMODULE"

exit

# copy pipeline files
if [[ "$GIT_PROVIDER" -eq "GITLAB" ]]; then
  yml_file="gitlab-ci.yml"
  echo "Installing $yml_file"
  cp "$KIT_ROOT/$yml_file" "$REP_ROOT/.$yml_file"
  cp -r "$KIT_ROOT/ci_tests" "$REP_ROOT/.gitlab-ci.d"
fi
