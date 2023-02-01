#!/usr/bin/env bash

# USAGE
# ------
# . <(curl -s https://raw.githubusercontent.com/CaseyLabs/kc-bash/main/kc-bash.sh)


# VARS
# ----
# Get location where this script runs from:
KC_SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

# check if we are running as root; if not, enable sudo as an option:
SUDO=''
if (( $EUID != 0 )); then
  SUDO='sudo'
fi


# FUNCTIONS
# ---------

# Notes:
#    $# = number of passed in arguments
# 

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
  kc_private_ip=$(hostname -I | awk '{print $1}')
  msg "${kc_private_ip}"
}

# prints external IP address
mypublicip() {
  kc_public_ip=$(curl -s ifconfig.me)
  msg "${kc_public_ip}"
}

# Find and replace text in a file | replace originalText newText /path/to/file.txt
replace() {
  if [[ $# -lt 3 ]] ; then
    msg "[Error] Invalid options. Usage: replace originalText newText /path/to/file.txt"
    return 1
  fi

  perl -i -pe"s/$1/$2/g" "$3"
}

# prints the AWS account your terminal is logged into
awsaccount() {
  kc_aws_account=$(aws sts get-caller-identity --query \"Account\" --output text)
  if [ -n "${kc_aws_account}" ]; then
    msg "[Info] Current AWS account ID: ${kc_aws_account}"
    return 0
  else
    msg "[Error] Current AWS account not detected."
    return 1
  fi
}

# List RUNNING services
services() {
  $SUDO service --status-all | grep -i +
}

# Uncompress .tar.gz file | unzipg sourceFile [destination]
function unzipg {
  if [[ $# -lt 1 ]] ; then
    msg "[Error] Insufficient arguments | Usage: unzipg sourceFile [destination] | Example: unzipg myFile.tar.gz ."
    return 1
  elif [[ $# -lt 2 ]] ; then
    set -- "$1" "." # sets to current directory
  elif ! checkDir $1; then
    mkdir -p $1
  fi
    tar -xvf "$1" "$2"
    return 0
}