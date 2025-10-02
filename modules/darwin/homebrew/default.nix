{ ... }:

{
  homebrew = {
    enable = true;

    onActivation.cleanup    = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade    = true;

    taps = [
      "thusvill/livewallpaper"
    ];

    # Put packages you want on *every* Mac here
    brews = [
      { name = "gmp"; link = true; }
      "libuv"
    ];

    casks = [
      "firefox@developer-edition"
      "sf-symbols"
      "font-sf-mono"
      "font-sf-pro"
      "ghostty"
      "licecap"
      "shottr"
      "slack"
      "zoom"
      "livewallpaper"
      "obsidian"
    ];
  };
}

