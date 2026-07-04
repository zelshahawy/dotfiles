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
      "harfbuzz" # C library for R
      "fribidi" # C library for R
      "pkg-config" # C library for R
      "libtiff" # C library for R (ragg)
      "libpng" # C library for R (ragg)
      "libjpeg-turbo" # C library for R (ragg)
      "webp" # C library for R (ragg)
    ];

    casks = [
      # "firefox@developer-edition"
      "sf-symbols"
      # "font-sf-pro"
      "ghostty"
      # "licecap"
      # "shottr"
      "slack"
      # "zoom"
      "obsidian"
      "tailscale-app"
      "arc"
      "kiro"
      "rstudio"
      "font-sketchybar-app-font"
      "orbstack"
      # "free-download-manager"
      "basictex"
      "microsoft-teams"
      "quarto"
    ];
  };
}
