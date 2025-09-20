{ hostname ? "nixos-desktop", pkgs, ... }:
let
  fullName = "Ziad Elshahawy";
  user = "ziadelshahawy";
  email = "ziad.a.elshahawy@gmail.com";
in
{
  users.users.${user} = {
    isNormalUser = true;
    description = fullName;
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  home-manager = {
    useGlobalPkgs = true;
    backupFileExtension = "bak";
    extraSpecialArgs = { inherit fullName user email hostname; };
    users.${user} = { pkgs, config, lib, ... }: {
      imports = [
        ../shared/programs
      ];
      home = {
        enableNixpkgsReleaseCheck = false;
        packages = pkgs.callPackage ../shared/packages.nix {
          inherit pkgs hostname;
          user = "${user}";
        };
        stateVersion = "23.11";
      };
    };
  };
}
