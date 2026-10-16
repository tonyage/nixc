# Stand-in for the private secrets repo, so CI can evaluate the flake without credentials:
#   --override-input secrets path:./.github/ci/secrets
{
  user  = "ci";
  name  = "ci";
  email = "ci@example.com";

  darwinHosts = [ "ci-darwin" ];
  nixosHosts  = [ "ci-nixos" ];
}
