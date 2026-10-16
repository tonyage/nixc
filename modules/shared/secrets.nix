{ lib, pkgs, secrets, identity, ... }:

# agenix secrets, shared by darwin and NixOS.
#
# Each machine decrypts with its own SSH host key (/etc/ssh/ssh_host_ed25519_key, agenix's
# default identityPaths). Who can decrypt each secret is declared in the secrets repo's
# agenix-rules.nix; see the README for adding a machine or editing a secret.
let
  inherit (identity) user;
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
  home = if isDarwin then "/Users/${user}" else "/home/${user}";
  group = if isDarwin then "staff" else "users";

  # Only declare a secret once its .age file exists, so a fresh secrets repo (or CI's stub) still evaluates
  secret = name: attrs: lib.optionalAttrs (builtins.pathExists "${secrets}/${name}.age") {
    ${name} = { file = "${secrets}/${name}.age"; owner = user; inherit group; } // attrs;
  };
in
{
  age.secrets = secret "github-ssh-key" {
    path = "${home}/.ssh/id_github"; # used for github.com in shared/home-manager.nix
    mode = "600";
  };
}
