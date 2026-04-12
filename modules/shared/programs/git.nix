{ ... }:
{
  programs.delta.enable = true;
  programs.delta.enableGitIntegration = true;
  programs.git = {
    enable = true;
    maintenance.enable = true;
    ignores = [
      "*.swp"
      ".DS_STORE"
    ];
    settings = {
      user.name = "Ziad Elshahawy";
      user.email = "ziadelshahawygit@gmail.com";
      init.defaultBranch = "main";
      core = {
        editor = "nvim";
        autocrlf = "input";
      };
      pull.rebase = true;
      rebase.autoStash = true;

    };
    lfs = {
      enable = true;
    };
  };
}
