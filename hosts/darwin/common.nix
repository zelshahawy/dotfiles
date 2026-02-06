{ config, pkgs, ... }:
{
  imports = [
    ../../modules/darwin
  ];

  system = {
    primaryUser = "ziadelshahawy";
    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    # Set Git commit hash for darwin-version.
    configurationRevision = config.rev or config.dirtyRev or null;

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };

    defaults = {
      # minimal dock
      dock = {
        autohide = true;
        orientation = "bottom";
        show-process-indicators = false;
        show-recents = false;
        static-only = true;
      };
      finder = {
        AppleShowAllExtensions = true;
        ShowPathbar = true;
        AppleShowAllFiles = true;
        FXEnableExtensionChangeWarning = false;
      };
    };
  };

  environment = {
    enableAllTerminfo = true;
    systemPackages = with pkgs; [
      sketchybar
      aerospace
    ];
  };

  fonts.packages = with pkgs.nerd-fonts; [
    caskaydia-cove
    recursive-mono
  ];

  security.pam.services.sudo_local.touchIdAuth = true;

  nix = {
    enable = true;
    settings = {
      experimental-features = "nix-command flakes";
      trusted-users = [ "ziadelshahawy" ];
    };

    package = pkgs.nixVersions.stable;
    gc.automatic = true;
    extraOptions = ''
      extra-platforms = x86_64-darwin aarch64-darwin
    '';
    # linux-builder.enable = true;
  };

  programs = {
    # Create /etc/zshrc that loads the nix-darwin environment.
    zsh.enable = true;
    bash.enable = true;

    nix-index.enable = true;
  };

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;
}
