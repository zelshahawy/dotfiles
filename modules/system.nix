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

  system.primaryUser = "ziadelshahawy";
  # Enable zsh.
  programs.zsh.enable = true;

  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

  # System packages.
  environment.systemPackages = with pkgs; [
    ncdu
    subversion
    python311
    gopls
    mas
    python312Packages.python-lsp-server
    nurl
    nil
    nixpkgs-fmt
    python312Packages.ipython
    lua
    rustup
    postgresql_17_jit
    boost
    cmake
    redis
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
      "boost"
    ];
    casks = [
      "maccy"
      "anki"
      "slack"
      "obsidian"
      "postman"
      "zoom"
      "1password"
      "docker-desktop"
      "firefox@developer-edition"
      "discord"
      "sf-symbols"
      "font-sf-mono"
      "loom"
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
      FXEnableExtensionChangeWarning = true;
      AppleShowAllFiles = true;
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
    extraConfig = builtins.readFile ../etc/yabairc;
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
