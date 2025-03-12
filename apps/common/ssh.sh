#!/usr/bin/env bash

source ./stdio.sh

export SSH_DIR="$HOME"/.ssh

setup_ssh_directory() {
  mkdir -p "${SSH_DIR}"
}

prompt_for_key_generation() {
  local key_name=$1
  if [[ -f "${SSH_DIR}/${key_name}" ]]; then
    _print "${RED}Existing SSH key found for ${key_name}.${NC}"
    cat "${SSH_DIR}/${key_name}.pub"
    read -rp "Do you want to replace it? (y/n) " -n 1
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      return 0 # Indicate key should be replaced
    else
      return 1 # Indicate key should be kept
    fi
  fi
  return 0 # Indicate no key exists, so it should be created
}

generate_key() {
  local key_name=$1
  if prompt_for_key_generation "$key_name"; then
    ssh-keygen -t ed25519 -f "${SSH_DIR}/${key_name}" -N ""
    chown "${USER}":staff "${SSH_DIR}/${key_name}"{,.pub}
  else
    echo -e "${GREEN}Kept existing ${key_name}.${NC}"
  fi
}

lint_keys() {
  if [[ -f "${SSH_DIR}/id_ed25519" && -f "${SSH_DIR}/id_ed25519.pub" && -f "${SSH_DIR}/id_ed25519_agenix" && -f "${SSH_DIR}/id_ed25519_agenix.pub" ]]; then
    _print "${GREEN}All SSH keys are present.${NC}"
  else
    _print "${RED}Some SSH keys are missing.${NC}"
    if [[ ! -f "${SSH_DIR}/id_ed25519" ]]; then
      _print "${RED}Missing: id_ed25519${NC}"
    fi
    if [[ ! -f "${SSH_DIR}/id_ed25519.pub" ]]; then
      _print "${RED}Missing: id_ed25519.pub${NC}"
    fi
    if [[ ! -f "${SSH_DIR}/id_ed25519_agenix" ]]; then
      _print "${RED}Missing: id_ed25519_agenix${NC}"
    fi
    if [[ ! -f "${SSH_DIR}/id_ed25519_agenix.pub" ]]; then
      _print "${RED}Missing: id_ed25519_agenix.pub${NC}"
    fi
    _print "${GREEN}Run the createKeys command to generate the missing keys.${NC}"
    exit 1
  fi
}
