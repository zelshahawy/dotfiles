{ ... }:
let
  catppuccin-starship = builtins.fetchGit {
    url = "https://github.com/catppuccin/starship.git";
    rev = "e99ba6b210c0739af2a18094024ca0bdf4bb3225";
  };
  theme = "mocha";
in
{
  programs.starship = {
    enable = true;
    settings = {
      palette = "catppuccin_${theme}";
    } // builtins.fromTOML (builtins.readFile "${catppuccin-starship}/themes/${theme}.toml");
  };
}
