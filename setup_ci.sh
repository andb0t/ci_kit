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
ROOT=$(git rev-parse --show-toplevel)
KIT_ROOT_PATH="$( cd "$(dirname "$0")" || exit; pwd -P )"/..

echo "ROOT         : $ROOT"
echo "KIT_ROOT_PATH: $KIT_ROOT_PATH"

exit

# copy pipeline files
if [[ "$GIT_PROVIDER" -eq "GITLAB" ]]; then
  yml_file="gitlab-ci.yml"
  echo "Installing $yml_file"
  cp "$KIT_ROOT_PATH/$yml_file" "$ROOT/.$yml_file"
  cp -r "$KIT_ROOT_PATH/ci_tests" "$ROOT/.gitlab-ci.d"
fi
