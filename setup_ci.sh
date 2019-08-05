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
REPO_DIFF="$(diff -q "$REP_ROOT" "$KIT_ROOT/..")"
if [[ -z "$REPO_DIFF" ]]; then
  IS_SUBMODULE="Y"
else
  IS_SUBMODULE="N"
fi


# copy pipeline files
if [[ "$GIT_PROVIDER" == "GITLAB" ]]; then
  source_yml_file="pipe_cfg/gitlab.yml"
  target_yml_file=".gitlab-ci.yml"
  cp "$KIT_ROOT/$source_yml_file" "$REP_ROOT/$target_yml_file"
elif [[ "$GIT_PROVIDER" == "GITHUB" ]]; then
  source_yml_file="pipe_cfg/github.yml"
  target_yml_file=".travis.yml"
  cp "$KIT_ROOT/$source_yml_file" "$REP_ROOT/$target_yml_file"
elif [[ "$GIT_PROVIDER" == "BITBUCKET" ]]; then
  source_yml_file="pipe_cfg/bitbucket.yml"
  target_yml_file="bitbucket-pipelines.yml"
  cp "$KIT_ROOT/$source_yml_file" "$REP_ROOT/$target_yml_file"
elif [[ "$GIT_PROVIDER" == "AZUREDEVOPS" ]]; then
  source_yml_file="pipe_cfg/azure.yml"
  target_yml_file="azure-pipelines.yml"
  cp "$KIT_ROOT/$source_yml_file" "$REP_ROOT/$target_yml_file"
else
  echo "Not implemented, yet! Please contribute!"
fi

# fix path placeholders in yml file
if [[ "$IS_SUBMODULE" == "Y" ]]; then
  SCRIPT_PATH="./ci_kit/"
else
  SCRIPT_PATH="."
fi
sed -i "s#CI_KIT_PATH#$SCRIPT_PATH#g" "$target_yml_file"

# copy scipts
if [[ "$IS_SUBMODULE" == "N" ]]; then
  # copy script files
  cp -r "$KIT_ROOT/githooks" "$REP_ROOT/.githooks"
  cp -r "$KIT_ROOT/git-ci.d" "$REP_ROOT/.git-ci.d"
fi
