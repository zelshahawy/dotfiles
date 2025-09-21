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
      "firefox@developer-edition"
      "font-sf-mono"
      "font-sf-pro"
      "licecap"
      "shottr"
      "slack"
      "spotify"
      "xquartz"
      "zoom"
      "google-chrome"
      "livewallpaper"
    ];

    taps = [
      "homebrew/services"
      "thusvill/livewallpaper"
    ];
  };
}
