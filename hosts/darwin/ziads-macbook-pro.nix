{ hostname, ... }:
{
  networking.computerName = "Ziad's MacBook Pro";
  networking.hostName = hostname;

  system = {
    defaults.smb.NetBIOSName = hostname;
    stateVersion = 5;
  };

}
