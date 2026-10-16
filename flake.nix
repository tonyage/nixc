{
  description = "Starter Configuration with secrets for MacOS and NixOS";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    agenix.url = "github:ryantm/agenix";
    home-manager.url = "github:nix-community/home-manager";
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    secrets = {
      url = "git+ssh://git@github.com/tonyage/secrets.git";
      flake = false;
    };
  };
  outputs = {
   self,
   darwin,
   nix-homebrew,
   homebrew-bundle,
   homebrew-core,
   homebrew-cask,
   home-manager,
   nixpkgs,
   disko,
   agenix,
   secrets
  } @inputs:
    let
      identity = import "${secrets}/identity.nix";
      inherit (identity) user;
      linuxSystems = [ "x86_64-linux" "aarch64-linux" ];
      darwinSystems = [ "aarch64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs (linuxSystems ++ darwinSystems) f;
      devShell = system: let pkgs = nixpkgs.legacyPackages.${system}; in {
        default = with pkgs; mkShell {
          nativeBuildInputs = with pkgs; [ bashInteractive git age age-plugin-yubikey ];
          shellHook = with pkgs; ''
            export EDITOR=nvim
          '';
        };
      };
    in {
      devShells = forAllSystems devShell;

      # One configuration per host in identity.darwinHosts; darwin-rebuild looks up
      # .#$(scutil --get LocalHostName) by default, so no target is needed on each Mac.
      darwinConfigurations = nixpkgs.lib.genAttrs identity.darwinHosts (hostName:
        darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = inputs // { inherit identity; };
          modules = [
            { networking.localHostName = hostName; }
            home-manager.darwinModules.home-manager
            nix-homebrew.darwinModules.nix-homebrew
            {
              nix-homebrew = {
                inherit user;
                enable = true;
                taps = {
                  "homebrew/homebrew-core" = homebrew-core;
                  "homebrew/homebrew-cask" = homebrew-cask;
                  "homebrew/homebrew-bundle" = homebrew-bundle;
                };
                mutableTaps = false;
                autoMigrate = true;
              };
            }
            ./hosts/darwin
          ];
        }
      );

      # One configuration per host in identity.nixosHosts; the attribute name is the hostname, so
      # `nixos-rebuild switch --flake .` picks the right one on each machine.
      nixosConfigurations = nixpkgs.lib.genAttrs identity.nixosHosts (hostName: nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs // { inherit identity; };
        modules = [
          { networking.hostName = hostName; }
          disko.nixosModules.disko
          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit identity; };
              users.${user} = import ./modules/nixos/home-manager.nix;
            };
          }
          ./hosts/nixos
        ];
      }
    );
  };
}
