#!/bin/bash

# define arguments
INSTALL="--install"
REMOVE="--remove"

TASK=""
if [ -z "$1" ]; then
  echo "No argument supplied! Chose one:"
  echo "[$INSTALL, $REMOVE]"
  exit
else
  TASK="$1"
fi

# get git directory
REP_ROOT=$(git rev-parse --show-toplevel)
KIT_ROOT="$( cd "$(dirname "$0")" || exit; pwd -P )"

# fill array with content of githooks folder
# shellcheck disable=SC2207
FILES=($(ls "$KIT_ROOT/.."/githooks))
# remove install file from files to be copied
thisfile=$(basename "$0")
FILES=("${FILES[@]/$thisfile}")

# do it!
if [[ $TASK == "$INSTALL" ]]; then
  for i in "${FILES[@]}"
  do
    if [ -z "$i" ]; then
      continue
    fi
    if [ -f "$REP_ROOT/.git/hooks/$i" ]; then
      echo "WARNING: File .git/hooks/$i already exists! Overwriting previous version..."
    else
      echo "Installing hook $i ..."
    fi
    cp "$KIT_ROOT/../githooks/$i" "$REP_ROOT/.git/hooks/$i"
    chmod +x "$REP_ROOT/.git/hooks/$i"
  done
elif [[ $TASK == "$REMOVE" ]]; then
  for i in "${FILES[@]}"
  do
    if [ -z "$i" ]; then
      continue
    fi
    if [ -f "$REP_ROOT/.git/hooks/$i" ]; then
      echo "Removing hook $i ..."
    else
      echo "WARNING: .git/hooks/$i does not exist! Skip removal..."
      continue
    fi
    rm "$REP_ROOT/.git/hooks/$i"
  done
fi
