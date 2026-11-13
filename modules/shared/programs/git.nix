{ ... }:
{
  programs.delta.enable = true;
  programs.delta.enableGitIntegration = false;
  programs.git = {
    enable = true;
    signing.format = "openpgp";
    maintenance.enable = false;
    ignores = [
      "*.swp"
      ".DS_STORE"
    ];

    settings = {
      user.name = "Ziad Elshahawy";
      user.email = "ziadelshahawygit@gmail.com";
      init.defaultBranch = "main";
      credential.helper = "osxkeychain";
      core = {
        editor = "nvim";
        autocrlf = "input";
      };
      pull.rebase = true;
      rebase.autoStash = true;

      pager = {
        log = "delta";
        show = "delta";
        blame = "delta";
      };

    };
    lfs = {
      enable = true;
    };
  };
}
