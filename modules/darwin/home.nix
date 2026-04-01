{ hostname ? "ziads-macbook-air"
, ...
}:
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
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJnED6Zn+RYtN3VwlTszF6CYW9dmINCy0QjgARJX5/13 ziadelshahawy@Ziads-Mac-mini.local"
      ];
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    backupFileExtension = "bak";
    extraSpecialArgs = {
      inherit
        fullName
        user
        email
        hostname
        ;
    };
    users.${user} =
      { pkgs
      , config
      , lib
      , ...
      }:
      {
        imports = [
          ../shared/programs
          ./programs
        ];
        home = {
          enableNixpkgsReleaseCheck = false;
          packages =
            pkgs.callPackage ./packages.nix { inherit pkgs hostname; }
            ++ pkgs.callPackage ../shared/packages.nix {
              inherit pkgs hostname;
              user = "${user}";
            };
          stateVersion = "23.11";
        };
        home.file."Library/Application Support/com.mitchellh.ghostty/config".text = ''
          font-size = 17
          background-blur = 20
          background-opacity = 0.85
        '';
      };
  };

}
