{
  description = "My system configuration ";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, mac-app-util }:
    let
      # Import the modular configurations.
      systemModule = import ./modules/system.nix;
      homeModule = import ./modules/home-manager.nix;
    in
    {
      darwinConfigurations."Ziads-MacBook-Air" = nix-darwin.lib.darwinSystem {
        modules = [
          systemModule
          mac-app-util.darwinModules.default
          home-manager.darwinModules.home-manager
          {
            # Additional Home Manager settings.
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.verbose = true;

            home-manager.sharedModules = [
              mac-app-util.homeManagerModules.default
            ];
            home-manager.backupFileExtension = "backup";

            # Use the imported Home Manager configuration.
            home-manager.users.ziadelshahawy = homeModule;
          }
        ];
      };
    };
}

