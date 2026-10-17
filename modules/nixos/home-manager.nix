{
  config,
  pkgs,
  lib,
  identity,
  ...
}:

let
  inherit (identity) user;
  colorscheme = import ../../colorschemes/dusk.nix;
  shared-programs = import ../shared/home-manager.nix {
    inherit
      colorscheme
      config
      pkgs
      lib
      identity
      ;
  };
  shared-files = import ../shared/files.nix {
    inherit
      colorscheme
      config
      pkgs
      lib
      ;
  };

in
{
  imports = [ ../shared/neovim.nix ];

  home = {
    enableNixpkgsReleaseCheck = false;
    username = "${user}";
    homeDirectory = "/home/${user}";
    packages = pkgs.callPackage ./packages.nix { };
    file = shared-files;
    stateVersion = "21.05";
  };

  programs = shared-programs // {
    gpg.enable = true;
  };

}
