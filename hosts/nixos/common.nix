# Common NixOS configuration
{ pkgs, ... }:
{
  imports = [
    ../../modules/nixos
  ];

  # Basic NixOS settings
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;
  time.timeZone = "America/Chicago"; # Adjust as needed

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [ "ziadelshahawy" ];
    };
    package = pkgs.nixVersions.stable;
    gc.automatic = true;
  };

  nixpkgs.config.allowUnfree = true;

  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    git
    curl
    wget
  ];

  system.stateVersion = "24.05"; # Adjust based on your NixOS version
}
