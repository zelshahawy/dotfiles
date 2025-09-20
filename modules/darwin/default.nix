{ ... }: {
  imports = [
    ./home.nix
    ./homebrew.nix
    ./services/yabai
    ./services/skhd
    ./services/sketchybar
  ];
}
