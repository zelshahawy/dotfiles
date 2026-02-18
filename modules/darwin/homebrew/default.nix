{ ... }:

{
  homebrew = {
    enable = true;

    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;

    taps = [
    ];

    # Put packages you want on *every* Mac here
    brews = [
      "libuv"
    ];

    casks = [
      "firefox@developer-edition"
      "sf-symbols"
      "font-sf-pro"
      "ghostty"
      "licecap"
      "shottr"
      "slack"
      "zoom"
      "obsidian"
      "docker-desktop"
      "tailscale-app"
      "arc"
      "kiro"
      "rstudio"
      "font-sketchybar-app-font"
      "orbstack"
      "blender"
    ];
  };
}
