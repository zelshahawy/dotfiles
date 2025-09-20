# NixOS system packages
{ pkgs, hostname ? "nixos-desktop", ... }:

let
  shared-packages = import ../shared/packages.nix { inherit pkgs hostname; user = "fadyadal"; };
in
shared-packages ++ [
  # NixOS-specific system packages
]
