{ pkgs, config, ... }:
let
  sketchybarConfig = pkgs.stdenv.mkDerivation {
    name = "sketchybar-config-v0.1.0";
    src = pkgs.fetchgit {
      url = "https://github.com/FelixKratz/dotfiles";
      rev = "1589c769e28f110b1177f6a83fa145235c8f7bd6";
      sha256 = "sha256-vo/PmrYlrg6kwBbFtrwbTZffLrQgzTSuqVxfNQba3YI=";
      fetchSubmodules = true; # <-- the key bit
    };

    # helpful if the repo has no ./configure step
    dontConfigure = true;

    # (optional) quick sanity check for debugging
    # postUnpack = ''echo "Tree:"; ls -la; ls -la .config || true'';

    buildInputs = [ pkgs.gnumake pkgs.lua5_4 ];
    buildPhase = ''
      patch -p0 -d ./.config/sketchybar -i ${./config.patch}
      make -C ./.config/sketchybar/helpers
    '';
    installPhase = ''
      # copy the *contents* of .config/sketchybar into $out
      cp -r ./.config/sketchybar "$out"
    '';
  };
in
{
  launchd.user.agents.sketchybar = {
    path =
      [ pkgs.sketchybar pkgs.lua5_4 pkgs.gnumake "/usr/bin" "/usr/sbin" ]
      ++ config.environment.systemPackages;

    environment = {
      LUA_PATH = "${sketchybarConfig}/?.lua;${sketchybarConfig}/?/?.lua;;";
    };

    command = "sketchybar --config ${sketchybarConfig}/sketchybarrc";

    serviceConfig = {
      KeepAlive = true;
      StandardErrorPath = "/tmp/sketchybar.stderr.log";
      StandardOutPath = "/tmp/sketchybar.stdout.log";
    };
  };
}

