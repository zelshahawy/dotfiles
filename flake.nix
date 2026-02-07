{
  description = "System Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    mac-app-util.url = "github:hraban/mac-app-util";

    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager/master";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs =
    {
      self,
      nix-darwin,
      nix-homebrew,
      home-manager,
      nixpkgs,
      mac-app-util,
      ...
    }@inputs:
    let
      # Common system builder function for Darwin
      mkDarwinSystem =
        {
          hostname,
          system ? "aarch64-darwin",
          extraModules ? [ ],
        }:
        nix-darwin.lib.darwinSystem {
          inherit system;
          modules = [
            mac-app-util.darwinModules.default
            home-manager.darwinModules.home-manager
            {
              home-manager.sharedModules = [
                mac-app-util.homeManagerModules.default
              ];
            }
            nix-homebrew.darwinModules.nix-homebrew
            {
              nix-homebrew = {
                enable = true;
                enableRosetta = true;
                user = "ziadelshahawy";
                autoMigrate = true;
              };
            }
            ./hosts/darwin/common.nix
            ./hosts/darwin/${hostname}.nix
          ]
          ++ extraModules;
          specialArgs = { inherit inputs hostname; };
        };

      # Common system builder function for NixOS
      mkNixosSystem =
        {
          hostname,
          system ? "x86_64-linux",
          extraModules ? [ ],
        }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            home-manager.nixosModules.home-manager
            ./hosts/nixos/common.nix
            ./hosts/nixos/${hostname}.nix
          ]
          ++ extraModules;
          specialArgs = { inherit inputs hostname; };
        };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#macbook-air
      # $ darwin-rebuild build --flake .#macbook-pro
      darwinConfigurations = {
        "macbook-air" = mkDarwinSystem {
          hostname = "ziads-macbook-air";
          system = "aarch64-darwin";
        };
        "mac-mini" = mkDarwinSystem {
          hostname = "ziads-mac-mini";
          system = "aarch64-darwin";
        };
      };

      # Build nixos flake using:
      # $ nixos-rebuild build --flake .#nixos-desktop
      nixosConfigurations = {
        "nixos-desktop" = mkNixosSystem {
          hostname = "ziads-nixos-desktop";
          system = "x86_64-linux";
        };
      };

      # For backward compatibility
      darwinConfigurations."ziads-MacBook-Air" = self.darwinConfigurations."macbook-air";

      # For backward compatibility
      darwinPackages = self.darwinConfigurations."macbook-air".pkgs;
    };
}
