#!/usr/bin/env bash

source ./stdio.sh

case $ARCH in
arm64)
  SYSTEM_TYPE="aarch64-${OS,,}"
  ;;
*)
  SYSTEM_TYPE="x86_64-${OS,,}"
  ;;
esac

export NIXPKGS_ALLOW_UNFREE=1

build() {
  echo -e "${YELLOW}Starting build for system $SYSTEM_TYPE...${NC}"

  FLAKE_SYSTEM="darwinConfigurations.${SYSTEM_TYPE}.system"
  nix --extra-experimental-features 'nix-command flakes' build .#"$FLAKE_SYSTEM" "$@"
}

switch() {
  echo -e "${YELLOW}Switching to new generation...${NC}"
  if [[ "$OS" != "Darwin" ]]; then
    # We pass SSH from user to root so root can download secrets from our private Github
    sudo SSH_AUTH_SOCK="$SSH_AUTH_SOCK" /run/current-system/sw/bin/nixos-rebuild switch --flake .#"$SYSTEM_TYPE" "$@"
  else
    ./result/sw/bin/darwin-rebuild switch --flake .#"$SYSTEM_TYPE" "$@"
  fi
}

clean() {
  echo -e "${YELLOW}Cleaning up...${NC}"
  [[ "$OS" == "Darwin" ]] && unlink ./result
  echo -e "${GREEN}Switch to new generation complete!${NC}"
}
