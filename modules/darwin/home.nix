{ hostname ? "macbook-air", ... }:
let
  fullName = "Ziad Elshahawy";
  user = "ziadelshahawy";
  uid = 501;
  email = "ziad.a.elshahawy@gmail.com";
in
{
  users = {
    knownUsers = [ user ];
    users.${user} = {
      name = "${user}";
      uid = uid;
      home = "/Users/${user}";
      isHidden = false;
      shell = "/run/current-system/sw/bin/zsh";
    };
  };

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
        packages = pkgs.callPackage ./packages.nix { inherit pkgs hostname; } ++
          pkgs.callPackage ../shared/packages.nix { inherit pkgs hostname; user = "${user}"; };
        stateVersion = "23.11";
      };
    };
  };

}
