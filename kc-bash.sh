#!/usr/bin/env bash

# Usage:
# . <(curl -s https://raw.githubusercontent.com/CaseyLabs/kc-bash/main/kc-bash.sh)

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

msg() {
  echo >&2 -e "${1-}"
}

# Functions
# ---------

dirExists() {
  if [[ -d "$1" ]]
  then
    msg "[Info] Directory ($1) exists."
    return 0
  else
    msg "[Error] Directory ($1) does NOT exist."
    return 1
  fi
}

fileExists() {
  if [[ -f "$1" ]]
  then
    msg "[Info] File ($1) exists."
    return 0
  else
    msg "[Error] File ($1) does NOT exist."
    return 1
  fi
}