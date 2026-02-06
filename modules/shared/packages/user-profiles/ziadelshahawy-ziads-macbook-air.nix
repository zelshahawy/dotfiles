# Package profile for ziad Elshahawy on macbook-air
{ pkgs }:

let
  base-packages = import ../base.nix { inherit pkgs; };
  development-packages = import ../development.nix { inherit pkgs; };
  media-packages = import ../media.nix { inherit pkgs; };
in
base-packages
++ development-packages
++ media-packages
++ [
  #pkgs.claude-code
  pkgs.nmap
]
