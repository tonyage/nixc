# nixos-config

Specs and definitions for provisioning any linux and macOS machine in a few
commands, leveraging the nix package manager. For macOS use `nix-determinate`
installer and for linux use `nixOS`, obviously.

## macos dependencies

1. `xcode-select --install` if on MacOS for all required developer dependencies
2. Install nix using the streamlined Determinate nix [installer](https://github.com/DeterminateSystems/nix-installer).

3. ```bash
   mkdir -p nix-config && cd nix-config && nix flake --extra-experimental-features 'nix-command flakes' init -t github:tonyage/nix-config
   ```

## setup & install

1. Apply relevant GitHub info `nix run .#apply`
2. Create ssh-keys `nix run .#create-keys`
3. Provision a system `nix run .#build`
4. Update current system provision `nix run .#build-switch`

## secret management

```bash

# TODO secret management to handle provisioning ssh public keys via `agenix`
# for user and system scopes
```
