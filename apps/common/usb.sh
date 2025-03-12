#!/usr/bin/env bash

source ./ssh.sh
source ./stdio.sh

handle_no_usb() {
  _print "${RED}No USB drive found or mounted.${NC}"
  _print "${GREEN}If you have not yet set up your keys, run the script to generate new SSH keys.${NC}"
  exit 1
}

mount_usb() {
  MOUNT_PATH=""
  for dev in $(diskutil list | grep -o 'disk[0-9]'); do
    MOUNT_PATH="$(diskutil info /dev/"${dev}" | grep \"Mount Point\" | awk -F: '{print $2}' | xargs)"
    if [ -n "${MOUNT_PATH}" ]; then
      _print "${GREEN}USB drive found at ${MOUNT_PATH}.${NC}"
      break
    fi
  done

  if [ -z "${MOUNT_PATH}" ]; then
    _print "${RED}No USB drive found.${NC}"
  fi
}

copy_keys() {
  if [ -n "${MOUNT_PATH}" ]; then
    cp "${MOUNT_PATH}/id_ed25519_agenix.pub" "${SSH_DIR}"
    cp "${MOUNT_PATH}/id_ed25519_agenix" "${SSH_DIR}"
    chmod 600 "${SSH_DIR}"/id_ed25519_{agenix,agenix.pub}
  else
    _print "${RED}No USB drive found. Aborting.${NC}"
    exit 1
  fi
}

set_keys() {
  cp "${MOUNT_PATH}"/id_ed25519_github.pub "${SSH_DIR}"/id_ed25519.pub
  cp "${MOUNT_PATH}"/id_ed25519_github "${SSH_DIR}"/id_ed25519
  chmod 600 "${SSH_DIR}"/id_ed25519
  chmod 644 "${SSH_DIR}"/id_ed25519.pub
}

change_ownership() {
  chown "${USER}":staff "${SSH_DIR}"/id_ed25519{,.pub}
  chown "${USER}":staff "${SSH_DIR}"/id_ed25519_{agenix,agenix.pub}
}
