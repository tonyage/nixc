# nix-config

Specs and definitions for provisioning macOS and Linux machines in a few commands with the Nix package manager. On macOS, install upstream Nix and let nix-darwin manage it; on Linux, use NixOS.

## Prerequisites (macOS)

1. Install the developer tools:

   ```bash
   xcode-select --install
   ```

2. Install upstream Nix with the official multi-user installer:

   ```bash
   sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
   ```

   Open a new terminal afterwards. This installer doesn't turn on flakes, so add `--extra-experimental-features 'nix-command flakes'` to `nix` commands until the first switch. After that, `hosts/darwin` turns them on.

   > [!NOTE]
   > **Why not Determinate's installer?** It now installs Determinate Nix, which manages its own daemon and `nix.conf`. That conflicts with `nix.enable = true` in `hosts/darwin`, which hands Nix to nix-darwin, and the first switch fails. If you want Determinate Nix anyway, set `nix.enable = false` in `hosts/darwin/default.nix`. Then also move the `nix.settings`, `nix.gc` and `nix.optimise` settings into Determinate's config, because nix-darwin ignores them when it doesn't manage Nix.

3. Clone this repo to `~/git/personal/nix-config`, the path `nh` is configured to use.

## Identity and hosts

User identity and the list of machines are read from `identity.nix` in the private `secrets` repo:

```nix
{
  user  = "<username>";
  name  = "<git user.name>";
  email = "<git user.email>";

  darwinHosts = [ "<LocalHostName>" ]; # darwinConfigurations.<name>
  nixosHosts  = [ "<hostname>" ];      # nixosConfigurations.<name>
}
```

Each host's hostname is set to its name, so rebuilds need no target. Fetching the `secrets` input needs an SSH key that GitHub accepts (`ssh-keygen -t ed25519`, then add the public key to GitHub).

To override git settings on a single machine (for example, a work email), create an untracked `~/.config/git/local`:

```ini
[user]
	email = me@work.com
```

## Setup

### New Mac

Pick a name from `darwinHosts` (or add one). The first switch sets the Mac's hostname to it.

```bash
cd ~/git/personal/nix-config

# Fetch inputs, including the private secrets repo, with your own SSH key; under sudo, root has none
nix --extra-experimental-features 'nix-command flakes' flake archive

sudo nix --extra-experimental-features 'nix-command flakes' run nix-darwin -- switch --flake .#<host>
```

To have agenix install secrets on the first switch, first register the Mac's host key as described under [Adding a machine](#adding-a-machine). Create the key if it's missing with `sudo ssh-keygen -A`.

### New NixOS machine

Add its hostname to `nixosHosts`, boot the NixOS installer, and pick the disk to format:

```bash
sudo nix run github:nix-community/disko/latest#disko-install -- \
  --flake github:tonyage/nix-config#<host> --disk vdb /dev/<disk>
```

### Day to day

| Task               | Command                                                                          |
| ------------------ | -------------------------------------------------------------------------------- |
| Rebuild and switch | `nh darwin switch` / `nh os switch` (shows a package diff first)                 |
| Without nh         | `sudo darwin-rebuild switch --flake .` / `sudo nixos-rebuild switch --flake .`   |
| Roll back          | `sudo darwin-rebuild --rollback` / `sudo nixos-rebuild switch --rollback`        |
| List generations   | `darwin-rebuild --list-generations` / `nixos-rebuild list-generations`           |
| Update inputs      | `nix flake update` (or `nix flake update secrets` after changing `identity.nix`) |

## Secret management

Secrets are encrypted with [agenix](https://github.com/ryantm/agenix) and stored as `.age` files in the private `secrets` repo:

- `modules/shared/secrets.nix` declares where each secret is installed.
- Every machine decrypts with its own SSH host key, `/etc/ssh/ssh_host_ed25519_key`.
- `agenix-rules.nix` in the secrets repo lists which keys can decrypt each secret.

Run `agenix` from this repo's devShell, inside the secrets repo:

```bash
cd ~/git/personal/secrets

# Edit a secret (as someone who can decrypt it)
nix develop ~/git/personal/nix-config -c agenix -e <name>.age

# Rekey every secret, decrypting with this machine's host key
sudo $(nix develop ~/git/personal/nix-config -c which agenix) -r -i /etc/ssh/ssh_host_ed25519_key
```

### Adding a machine

1. On the new machine, print its host key: `cat /etc/ssh/ssh_host_ed25519_key.pub`.
2. Add the key to `hosts` in `agenix-rules.nix`.
3. Rekey (`agenix -r`) from a machine that can already decrypt, and push the secrets repo.
4. Run `nix flake update secrets` here, then rebuild.

Until then, that machine can't decrypt, and agenix logs an error when you switch.

### Adding a YubiKey

1. Run `age-plugin-yubikey` once to create an identity. It asks for your PIN and a touch.
2. Add the `age1yubikey1…` recipient from `age-plugin-yubikey --list` to `users` in `agenix-rules.nix`.
3. Rekey.

After that, you can edit secrets from any machine with the YubiKey plugged in.

### Bootstrapping

A brand-new machine has to fetch the private `secrets` input before agenix can install the GitHub key. For that first build, use a temporary key or token that GitHub accepts.
