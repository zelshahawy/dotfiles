{ ... }:

{
  services.skhd = {
    enable = true;
    skhdConfig = builtins.readFile ./skhdrc;
  };
  launchd.user.agents.skhd.serviceConfig =
    {
      StandardErrorPath = "/tmp/skhd.stderr.log";
      StandardOutPath = "/tmp/skhd.stdout.log";
    };
}
