#!/bin/bash

# By: Harry Wright <haroldtomwright@gmail.com>
# License: Apache License 2.0
# Source repo: https://github.com/harrytwright/mktouch

set -e
# Help options
opt_h=0
# Get the commands
MKDIR=$(which mkdir)
TOUCH=$(which touch)
# Colours
RESET=""
RED=""

# Check for this as it can fail or we just remove colours
if [ "${TERM}" != "" ]; then
  # Reset
  RESET=$(tput sgr0)    # Text Reset
  # Regular Colors
  RED=$(tput setaf 1)   # Red
fi

usage() {
  echo "$(basename $0) [opts] <directory> - <files>"
  echo ""
  echo "Example:"
  echo "  $ $(basename $0) ./src/example -- {index,demo}.js"
  echo ""
  echo "Options:"
  echo "  -h:        This help message"
  echo ""
  [ "$opt_h" = "1" ] && exit 0 || exit 1
}

create_path () {
  arguments=("$@")

  dir=${arguments[0]}
  unset 'arguments[0]'

  echo "=> Creating ${dir}"
  MKDIR -p "${dir}"

  for file in "${arguments[@]}" ; do
      TOUCH "${dir}/${file}"
  done
}

while getopts 'h:' opt; do
  # shellcheck disable=SC2220
  case $opt in
    h) opt_h=1;;
  esac
done
shift $(expr "$OPTIND" - 1)

if [ $# -le 1 -o "$opt_h" = "1" ]; then
  usage
fi

DIRS=()
FILES=()

# Get all the dirs
for argument in "$@"; do
  if [ "${argument}" == '-' ]; then
    shift;
    break;
  fi

  DIRS+=("${argument}")
  shift;
done

if [ ${#DIRS[@]} -lt 1 ]; then
  echo "${RED}No directories to create${RESET}"
  echo ""
  usage
fi

# Get the files
for argument in "$@"; do
  FILES+=("${argument}")
done

if [ ${#FILES[@]} -lt 1 ]; then
  echo "${RED}No files to create${RESET}"
  echo ""
  usage
fi

# Run the script
for directory in "${DIRS[@]}" ; do
    create_path "${directory}" "${FILES[@]}"
done
