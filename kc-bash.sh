#!/usr/bin/env bash

HELP_TEXT=""

# Functions
# ---------

dirExists() {
  if [[ -d "$1" ]]
  then
    echo "[Info] Directory ($1) exists."
    return 0
  else
    echo "[Error] Directory ($1) does NOT exist."
    return 1
  fi
}

fileExists() {
  if [[ -f "$1" ]]
  then
    echo "[Info] File ($1) exists."
    return 0
  else
    echo "[Error] File ($1) does NOT exist."
    return 1
  fi
}