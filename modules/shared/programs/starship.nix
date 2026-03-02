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
    settings =
      (builtins.fromTOML (builtins.readFile "${catppuccin-starship}/themes/${theme}.toml"))
      // {
        palette = "catppuccin_${theme}";
        add_newline = true;
        format = "$hostname $directory $git_branch$git_status$line_break$character";

        hostname = {
          disabled = false;
          ssh_only = false;
          style = "bold green";
          format = "[$hostname]($style)";
        };

        directory = {
          format = "[@$path]($style)";
        };

        line_break = {
          disabled = false;
        };
      };
  };
}
