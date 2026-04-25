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
      "r"
    ];

    casks = [
      # "firefox@developer-edition"
      "sf-symbols"
      "font-sf-pro"
      "ghostty"
      "licecap"
      "shottr"
      "slack"
      # "zoom"
      "obsidian"
      "tailscale-app"
      "arc"
      "kiro"
      "rstudio"
      "font-sketchybar-app-font"
      "orbstack"
      "free-download-manager"
      "basictex"
      "microsoft-teams"
    ];
  };
}
