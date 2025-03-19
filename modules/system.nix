{ pkgs, ... }:

{
  # Enable experimental features for flakes.
  nix.settings.experimental-features = "nix-command flakes";
  # For backwards compatibility.
  system.stateVersion = 5;

  # Set the host platform (for Apple Silicon use "aarch64-darwin").
  nixpkgs.hostPlatform = "aarch64-darwin";

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
    llvmPackages_19.clang-unwrapped
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
    ];
    casks = [
      "font-fira-code-nerd-font"
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
    ];
    taps = [
      "homebrew/services"
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
    config = {
      # Here you can set Yabai options declaratively
      layout = "bsp";
      window_gap = 10;
      mouse_follows_focus = "off";
      window_border = "on";
    };
    extraConfig = ''
      # You can also include raw yabai commands, e.g. rules
      yabai -m rule --add app="Finder" manage=off
    '';
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
}
