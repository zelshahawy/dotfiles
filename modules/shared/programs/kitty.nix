{ pkgs, ... }:
{
  programs.kitty = {
    enable = false;
    package = pkgs.kitty.overrideAttrs (oldAttrs: {
      doInstallCheck = false;
    });
    font = {
      size = 19;
      name = "SF Mono Light";
    };
    themeFile = "Catppuccin-Mocha";
    settings = {
      background_blur = 1;
    };
  };
}
