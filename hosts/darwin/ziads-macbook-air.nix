{ hostname, ... }:
{
  networking.computerName = "Ziad's MacBook Air";
  networking.hostName = hostname;

  system = {
    defaults.smb.NetBIOSName = hostname;
    stateVersion = 5;
  };

}
