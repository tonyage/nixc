{ config, pkgs, lib, home-manager, ... }:

let
  user = "tdo";
  # Define the content of your file as a derivation
  sharedFiles = import ../shared/files.nix { inherit config pkgs; };
  additionalFiles = import ./files.nix { inherit user config pkgs; };
  colorscheme = import ../../colorschemes/dusk.nix;
in
{
  imports = [
   ./dock
  ];

  # It me
  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };

  homebrew = {
    enable = true;
    casks = pkgs.callPackage ./casks.nix {};
    # onActivation.cleanup = "uninstall";

    # These app IDs are from using the mas CLI app
    # mas = mac app store
    # https://github.com/mas-cli/mas
    #
    # $ nix shell nixpkgs#mas
    # $ mas search <app name>
    #
    # If you have previously added these apps to your Mac App Store profile (but not installed them on this system),
    # you may receive an error message "Redownload Unavailable with This Apple ID".
    # This message is safe to ignore. (https://github.com/dustinlyons/nixos-config/issues/83)
  };

  # Enable home-manager
  home-manager = {
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit colorscheme; };
    users.${user} = { pkgs, config, lib, ... }:{
      home = {
        enableNixpkgsReleaseCheck = false;
        packages = pkgs.callPackage ./packages.nix {};
        file = lib.mkMerge [
          sharedFiles
          additionalFiles
        ];

        stateVersion = "23.11";
      };
      programs = {} // import ../shared/home-manager.nix { inherit colorscheme config pkgs lib; };

      # Marked broken Oct 20, 2022 check later to remove this
      # https://github.com/nix-community/home-manager/issues/3344
      manual.manpages.enable = false;
    };
  };

  # Fully declarative dock using the latest from Nix Store
  local = { 
    dock = {
      enable = true;
      entries = [
        { path = "/System/Applications/Music.app/"; }
        { path = "/System/Applications/Calendar.app/"; }
        { path = "/System/Applications/Mail.app/"; }
        { path = "/System/Cryptexes/App/System/Applications/Safari.app/"; }
        { path = "/Applications/Slack.app/"; }
        { path = "/Applications/Microsoft\ Teams.app/"; }
        { path = "/Applications/IntelliJ\ IDEA.app/"; }
        { path = "${pkgs.alacritty}/Applications/Alacritty.app/"; }
        { path = "/System/Applications/Utilities/Terminal.app/"; }
        { path = "/System/Applications/System\ Settings.app"; }
        {
          path = "${config.users.users.${user}.home}/Downloads/";
          section = "others";
          options = "--sort name --view grid --display folder";
        }
      ];
    };
  };
}
