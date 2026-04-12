{ hostname, lib, ... }:
{
  networking.computerName = "Ziad's MacBook Pro";
  networking.hostName = hostname;

  system = {
    defaults.smb.NetBIOSName = hostname;
    stateVersion = 5;
  };
  nix.enable = lib.mkForce false;
  nix.gc.automatic = lib.mkForce false;

}
