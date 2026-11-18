{
  hostname ? "ziads-macbook-air",
  ...
}:
{
  imports = [
    ./homebrew/default.nix
    (./homebrew + "/${hostname}.nix")
  ];
}
