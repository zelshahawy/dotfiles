{
  pkgs,
  hostname ? "ziads-macbook-air",
  ...
}:

let
  shared-packages = import ../shared/packages.nix { inherit pkgs; };
  base-packages = import ./packages/base.nix { inherit pkgs; };
  system-packages = import ./packages/${hostname}.nix { inherit pkgs; };
in
shared-packages ++ base-packages ++ system-packages
