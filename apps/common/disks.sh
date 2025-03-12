#!/usr/bin/env bash

source ./stdio.sh

select_boot_disk() {
  local disks
  local _boot_disk

  _print "${YELLOW}Available disks:${NC}"
  disks=$(lsblk -nd --output NAME,SIZE | grep -v loop)
  _print "$disks"

  # Warning message for data deletion
  _print "${RED}WARNING: All data on the chosen disk will be erased during the installation!${NC}"
  _prompt "${YELLOW}Please enter the name of your boot disk (e.g., sda, nvme0n1). Do not include the full path (/dev/): ${NC}" _boot_disk

  # Confirmation for disk selection to prevent accidental data loss
  _print "${YELLOW}You have selected $_boot_disk as the boot disk. This will delete everything on this disk. Are you sure? (Y/N): ${NC}"
  read -r confirmation
  if [[ "$confirmation" =~ ^[Yy]$ ]]; then
    export BOOT_DISK=$_boot_disk
  else
    _print "${RED}Disk selection cancelled by the user. Please run the script again to select the correct disk.${NC}"
    exit 1
  fi
}
