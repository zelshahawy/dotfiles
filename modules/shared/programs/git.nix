{ fullName, email, ... }:
{
  programs.git = {
    enable = true;
    delta.enable = true;
    ignores = [ "*.swp" ".DS_STORE" ];
    userName = fullName;
    userEmail = email;
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
