# nixos-config

1. `xcode-select --install` if on MacOS for all required developer dependencies
2. Install nix using the streamlined Determinate nix [installer](https://github.com/DeterminateSystems/nix-installer).
3. ```bash
   mkdir -p nix-config && cd nix-config && nix flake --extra-experimental-features 'nix-command flakes' init -t github:tonyage/nix-config-v2
   ```
4. Apply relevant GitHub info `nix run .#apply`
5. Create ssh-keys `nix run .#create-keys`
6. Provision a system `nix run .#build`
7. Update current system provision `nix run .#build-switch`

# secret management

```bash

# TODO secret management to handle provisioning ssh public keys via `agenix` for user and system scopes
```
