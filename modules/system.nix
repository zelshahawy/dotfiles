{ pkgs, ... }:

{
  # Enable experimental features for flakes.
  nix.settings.experimental-features = "nix-command flakes";
  # For backwards compatibility.
  system.stateVersion = 5;

  # Set the host platform (for Apple Silicon use "aarch64-darwin").
  nixpkgs.hostPlatform = "aarch64-darwin";
  nix.optimise.automatic = true;

  # User configuration.
  users.users.ziadelshahawy = {
    name = "ziadelshahawy";
    home = "/Users/ziadelshahawy";
  };

  # Enable zsh.
  programs.zsh.enable = true;

  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

  # System packages.
  environment.systemPackages = with pkgs; [
    ncdu
    subversion
    python312
    gopls
    mas
    python312Packages.python-lsp-server
    nurl
    nil
    nixpkgs-fmt
    yarn
    azure-cli
    nodejs_23
    python312Packages.ipython
    lua
  ];

  # Homebrew configuration.
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };
    brews = [
      "mongodb/brew/mongodb-community"
      "redis"
      "thefuck"
      "sketchybar"
      "jq"
      "gh"
      "gcc"
    ];
    casks = [
      "maccy"
      "anki"
      "slack"
      "obsidian"
      "microsoft-powerpoint"
      "postman"
      "zoom"
      "1password"
      "docker"
      "firefox@developer-edition"
      "discord"
      "utm"
      "sf-symbols"
      "font-sf-mono"
      "font-sf-pro"
    ];
    taps = [
      "homebrew/services"
      "FelixKratz/formulae"
    ];
    masApps = { };
  };

  # Enable Touch ID for sudo.
  security.pam.services.sudo_local.touchIdAuth = true;

  # Default system settings.
  system.defaults = {
    dock = {
      autohide = true;
      orientation = "bottom";
      show-process-indicators = false;
      show-recents = false;
      static-only = true;
      magnification = false;
    };
    finder = {
      AppleShowAllExtensions = true;
      ShowPathbar = true;
      FXEnableExtensionChangeWarning = false;
      AppleShowAllFiles = false;
    };
    trackpad = { };
  };

  # Nix garbage collection.
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 15d";
  };
  services.yabai = {
    enable = true;
    package = pkgs.yabai; # Use Yabai from Nix packages
    extraConfig = builtins.readFile ../etc/yabairc;
  };
  services.jankyborders = {
    enable = true;
    package = pkgs.jankyborders;
    style = "round";
    width = 6.0;
    hidpi = false;
    active_color = "0xc0e2e2e3";
    inactive_color = "0xc02c2e34";
    background_color = "0x302c2e34";
    blur_radius = 25.0;
  };
  services.skhd = {
    enable = true;
    skhdConfig = builtins.readFile ../etc/skhdrc;
  };
  launchd.user.agents.skhd.serviceConfig =
    {
      StandardErrorPath = "/tmp/skhd.stderr.log";
      StandardOutPath = "/tmp/skhd.stdout.log";
    };

}
