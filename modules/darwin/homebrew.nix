{ ... }:

{
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;

    brews = [
      {
        name = "gmp";
        link = true;
      }
      "libuv"
    ];

    casks = [
      "firefox"
      "font-sf-mono"
      "font-sf-pro"
      "ghostty"
      "licecap"
      "rstudio"
      "shottr"
      "slack"
      "spotify"
      "steam"
      "whatsapp"
      "whisky"
      "xquartz"
      "zoom"
    ];
  };
}
