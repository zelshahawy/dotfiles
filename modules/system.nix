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
      "vmware-fusion"
      "slack"
      "obsidian"
      "microsoft-powerpoint"
      "postman"
      "zoom"
      "1password"
      "docker"
      "firefox@developer-edition"
      "adobe-creative-cloud"
    ];
    taps = [
      "homebrew/services"
    ];
    masApps = {
      Xcode = 497799835;
    };
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
}

