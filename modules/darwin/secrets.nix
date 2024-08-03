{ config, pkgs, agenix, secrets, ... }:

let user = "tdo"; in
{
  # Note: the installWithSecrets command you ran to boostrap the machine actually copies over
  #       a Github key pair. However, if you want to store the keypair in your nix-secrets repo
  #       instead, you can reference the age files and specify the symlink path here. Then add your
  #       public key in shared/files.nix.
  #
  #       If you change the key name, you'll need to update the SSH configuration in shared/home-manager.nix
  #       so Github reads it correctly.
  age = {
    identityPaths = [
      "/Users/${user}/.ssh/id_ed25519"
    ];
    secrets = {
      "github-ssh-key" = {
        symlink = true;
        path = "/Users/${user}/.ssh/id_github";
        file =  "${secrets}/github-ssh-key.age";
        mode = "600";
        owner = "${user}";
        group = "staff";
      };
    };
  };
}
