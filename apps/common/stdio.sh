#!/usr/bin/env bash

export GREEN='\033[1;32m'
export RED='\033[1;31m'
export YELLOW='\033[1;33m'
export NC='\033[0m'

ARCH="$(uname -m)"
OS="$(uname)"

export ARCH
export OS

_print() {
  if [[ "$OS" == "Darwin" ]]; then
    echo -e "$1"
  else
    echo "$1"
  fi
}

_prompt() {
  local message="$1"
  local variable="$2"

  _print "$message"
  read -r "${variable?}"
}

git_info() {
  if [[ "$USER" == "nixos" ]] || [[ "$USER" == "root" ]]; then
    _prompt "${YELLOW}You're running as $USER. Please enter your desired username: ${NC}" USER
  fi

  # Check if git is available
  if command -v git >/dev/null 2>&1; then
    # Fetch email and name from git config
    GIT_EMAIL=$(git config --get user.email)
    export GIT_EMAIL
    GIT_NAME=$(git config --get user.name)
    export GIT_NAME
  else
    _print "${RED}Git is not available on this system.${NC}"
  fi

  # If git email is not found or git is not available, ask the user
  if [[ -z "$GIT_EMAIL" ]]; then
    _prompt "${YELLOW}Please enter your email: ${NC}" GIT_EMAIL
  fi

  # If git name is not found or git is not available, ask the user
  if [[ -z "$GIT_NAME" ]]; then
    _prompt "${YELLOW}Please enter your name: ${NC}" GIT_NAME
  fi

  _prompt "${YELLOW}Please enter your Github username: ${NC}" GITHUB_USER
  _prompt "${YELLOW}Please enter your Github secrets repository name: ${NC}" GITHUB_SECRETS_REPO

  export GITHUB_USER
  export GITHUB_SECRETS_REPO
}

confirm_details() {
  _print "${GREEN}Username: $USER"
  _print "Email: $GIT_EMAIL"
  _print "Name: $GIT_NAME${NC}"

  if [[ "$OS" != "Darwin" ]]; then
    _print "${GREEN}Primary interface: $PRIMARY_IFACE"
    _print "Boot disk: $BOOT_DISK"
    _print "Hostname: $HOST_NAME${NC}"
  fi

  _print "${GREEN}Secrets repository: $GITHUB_USER/$GITHUB_SECRETS_REPO${NC}"

  _prompt "${YELLOW}Is this correct? (Yes/No): ${NC}" choice
  choice="${choice:-yes}"

  case "$choice" in
  [Nn] | [Nn][Oo])
    _print "${RED}Exiting script.${NC}"
    exit 1
    ;;
  [Yy] | [Yy][Ee][Ss])
    _print "${GREEN}Continuing...${NC}"
    ;;
  *)
    _print "${RED}Invalid option. Exiting script.${NC}"
    exit 1
    ;;
  esac
}
