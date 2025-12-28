{ pkgs, ... }:
let
  sketchybarConfig = pkgs.stdenv.mkDerivation {
    name = "sketchybar-config-v0.1.0";
    src = ./config;
    buildPhase = ''
      make -C ./helpers
    '';
    installPhase = ''
      cp -r . $out
    '';
  };
in
{
  programs.sketchybar = {
    enable = true;
    config = {
      source = sketchybarConfig;
      recursive = true;
    };
    configType = "lua";
    extraPackages = [ pkgs.gnumake pkgs.aerospace ];
  };
}
