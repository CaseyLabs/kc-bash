#!/usr/bin/env bash

# USAGE
# ------
# . <(curl -s https://raw.githubusercontent.com/CaseyLabs/kc-bash/main/kc-bash.sh)


# VARS
# ----
# Get location where this script runs from:
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

# check if we are running as root; if not, enable sudo as an option:
SUDO=''
if (( $EUID != 0 )); then
  SUDO='sudo'
fi


# FUNCTIONS
# ---------

# Send logging output to stderr:
msg() {
  echo >&2 -e "${1-}"
}

# check if directory exists: checkdir /path/to/myDir
checkdir() {
  if [[ -d "$1" ]]; then
    msg "[Info] Directory ($1) exists."
    return 0
  else
    msg "[Error] Directory ($1) does NOT exist."
    return 1
  fi
}

# check if file exists: checkfile /path/to/myFile
checkfile() {
  if [[ -f "$1" ]]; then
    msg "[Info] File ($1) exists."
    return 0
  else
    msg "[Error] File ($1) does NOT exist."
    return 1
  fi
}

# install a system package (Linux): get package1 package2 package3
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

# upgrades all system packages (Linux only)
upgrade() {
  if command -v apt-get; then
    if [ -z "$(find /var/cache/apt/pkgcache.bin -mmin -60)" ]; then
      $SUDO apt-get update
    fi
    $SUDO apt-get upgrade -y
    $SUDO apt-get -y autoremove
    $SUDO apt-get clean
  elif command -v yum; then
    $SUDO yum upgrade -y
  fi
}

# prints internal IP address
myip() {
  hostname -I | awk '{print $1}'
}

# prints external IP address
mypublicip() {
  curl -s ifconfig.me
}

# Find and replace text in a file: replace originalText newText /path/to/file.txt
replace() {
  if [[ $# -lt 3 ]] ; then
    echo "Invalid options. Usage: replace originalText newText /path/to/file.txt"
    return 1
  fi

  perl -i -pe"s/$1/$2/g" "$3"
}

# prints the AWS account your terminal is logged into
awsaccount() {
  echo $(aws sts get-caller-identity --query \"Account\" --output text)
}

# List RUNNING services
services() {
  $SUDO service --status-all | grep -i +
}
