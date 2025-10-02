{ hostname, ... }: {
  # MacBook Pro specific configuration
  networking.computerName = "Ziad's Mac Mini";
  networking.hostName = hostname;

  system = {
    defaults.smb.NetBIOSName = hostname;
    defaults.dock.tilesize = 48; # Larger dock on mini
    stateVersion = 5;
  };
}

