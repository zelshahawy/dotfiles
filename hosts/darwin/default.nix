# Legacy default.nix - use common.nix + specific configs instead
{ ... }: {
  imports = [
    ./common.nix
    ./macbook-air.nix # Default to macbook-air for backward compatibility
    ./mac-mini.nix
  ];
}
