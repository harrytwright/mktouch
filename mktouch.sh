#!/bin/bash

# By: Harry Wright <haroldtomwright@gmail.com>
# License: Apache License 2.0
# Source repo: https://github.com/harrytwright/mktouch

set -e
# Help options
opt_h=0
opt_v=0
# Get the commands
MKDIR=$(which mkdir)
TOUCH=$(which touch)
# Colours
RED=$'\e[1;31m'
GRN=$'\e[1;32m'
YEL=$'\e[1;33m'
BLU=$'\e[1;34m'
BLD=$'\e[1;1m'
END=$'\e[0m'

log() {
  [ "$opt_v" = "1" ] && echo "$@"
}

version() {
  log "version: 1.0.0"
}

usage() {
  echo "${GRN}$(basename $0)${END} [opts] <directory> - <files>"
  echo ""
  echo "Example:"
  echo "  $ ${GRN}$(basename $0)${END} ./src/example - {index,demo}.js"
  echo ""
  echo "Options:"
  echo "  -h:        This help message"
  log ""
  version
  [ "$opt_h" = "1" ] && exit 0 || exit 1
}

create_path () {
  arguments=("$@")

  dir=${arguments[0]}
  unset 'arguments[0]'

  log ${GRN}"=>${END} Creating ${dir}"
  ${MKDIR} -p "${dir}"

  for file in "${arguments[@]}" ; do
    ${TOUCH} "${dir}/${file}"
  done
}

while getopts ':vh' opt; do
  # shellcheck disable=SC2220
  case $opt in
    h) opt_h=1;;
    v) opt_v=1;;
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
  echo "${RED}No directories to create${END}"
  echo ""
  usage
fi

# Get the files
for argument in "$@"; do
  FILES+=("${argument}")
done

if [ ${#FILES[@]} -lt 1 ]; then
  echo "${RED}No files to create${END}"
  echo ""
  usage
fi

# Run the script
for directory in "${DIRS[@]}" ; do
    create_path "${directory}" "${FILES[@]}"
done
