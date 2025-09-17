{ pkgs, hostname ? "macbook-air", user ? "ziadelshahawy" }:

# Load user-specific package profile based on user and hostname
import ./packages/user-profiles/${user}-${hostname}.nix { inherit pkgs; }

