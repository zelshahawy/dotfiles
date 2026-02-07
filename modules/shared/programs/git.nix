{ ... }:
{
  programs.git = {
    enable = true;
    delta.enable = true;
    maintenance.enable = true;
    ignores = [
      "*.swp"
      ".DS_STORE"
    ];
    userName = "Ziad Elshahawy";
    userEmail = "ziadelshahawygit@gmail.com ";
    lfs = {
      enable = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
      core = {
        editor = "nvim";
        autocrlf = "input";
      };
      pull.rebase = true;
      rebase.autoStash = true;
    };
  };
}
