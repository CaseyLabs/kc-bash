#!/usr/bin/env bash

# Usage
# ------
# . <(curl -s https://raw.githubusercontent.com/CaseyLabs/kc-bash/main/kc-bash.sh)

# Vars
# ----
# Get location where this script runs from:
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

# check if we are running as root; if not, enable sudo as an option:
SUDO=''
if (( $EUID != 0 )); then
  SUDO='sudo'
fi

# Functions
# ---------

# Send logging output to stderr:
msg() {
  echo >&2 -e "${1-}"
}

# check if directory exists: dirExists /path/to/myDir
dirExists() {
  if [[ -d "$1" ]]; then
    msg "[Info] Directory ($1) exists."
    return 0
  else
    msg "[Error] Directory ($1) does NOT exist."
    return 1
  fi
}

# check if file exists: fileExists /path/to/myFile
fileExists() {
  if [[ -f "$1" ]]; then
    msg "[Info] File ($1) exists."
    return 0
  else
    msg "[Error] File ($1) does NOT exist."
    return 1
  fi
}

# install a system package: get package1 package2 package3
get() {
  if command -v apt-get; then
    if [ -z "$(find /var/cache/apt/pkgcache.bin -mmin -60)" ]; then
      $SUDO apt-get update
    fi
    $SUDO apt-get install -y "$@"
    $SUDO apt-get -y autoremove
    $SUDO apt-get clean
  elif command -v yum; then
    $SUDO yum install -y "$@"
  fi
}

# prints internal IP address
myIP() {
  hostname -I | awk '{print $1}'
}

# prints external IP address
myPublicIP() {
  curl -s ifconfig.me
}