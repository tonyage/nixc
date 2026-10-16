# nixos-config

Specs and definitions for provisioning any linux and macOS machine in a few
commands, leveraging the nix package manager. For macOS use `nix-determinate`
installer and for linux use `nixOS`, obviously.

## macos dependencies

1. `xcode-select --install` if on MacOS for all required developer dependencies
2. Install nix using the streamlined Determinate nix [installer](https://github.com/DeterminateSystems/nix-installer).

3. Clone this repo to `~/git/personal/nix-config` (the path `nh` is configured to use).

## identity & hosts

User identity and the list of machines are read from `identity.nix` in the private `secrets` repo:

```nix
{
  user  = "<username>";
  name  = "<git user.name>";
  email = "<git user.email>";

  darwinHosts = [ "<LocalHostName>" ];      # darwinConfigurations.<name>
  nixosHosts  = [ "<hostname>" ];           # nixosConfigurations.<name>
}
```

Each host's hostname is set to its name, so rebuilds need no target. Fetching the `secrets` input needs an SSH key that GitHub accepts (`ssh-keygen -t ed25519`, then add the public key to GitHub).

To override git settings on a single machine (e.g. a work email), create an untracked `~/.config/git/local`:

```ini
[user]
	email = me@work.com
```

## setup & install

### new Mac

Add its `scutil --get LocalHostName` to `darwinHosts`, then bootstrap nix-darwin:

```bash
sudo nix run nix-darwin -- switch --flake .#<LocalHostName>
```

### new NixOS machine

Add its hostname to `nixosHosts`, boot the NixOS installer, and pick the disk to format:

```bash
sudo nix run github:nix-community/disko/latest#disko-install -- \
  --flake github:tonyage/nix-config#<host> --disk vdb /dev/<disk>
```

### day to day

| task | command |
| --- | --- |
| rebuild and switch | `nh darwin switch` / `nh os switch` (shows a package diff first) |
| without nh | `sudo darwin-rebuild switch --flake .` / `sudo nixos-rebuild switch --flake .` |
| roll back | `sudo darwin-rebuild --rollback` / `sudo nixos-rebuild switch --rollback` |
| list generations | `darwin-rebuild --list-generations` / `nixos-rebuild list-generations` |
| update inputs | `nix flake update` (or `nix flake update secrets` after changing `identity.nix`) |

## secret management

```bash

# TODO secret management to handle provisioning ssh public keys via `agenix`
# for user and system scopes
```
