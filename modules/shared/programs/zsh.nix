{ ... }:
let
  catppuccin-zsh-syntax-highlighting = builtins.fetchGit {
    url = "https://github.com/catppuccin/zsh-syntax-highlighting.git";
    rev = "7926c3d3e17d26b3779851a2255b95ee650bd928";
  };
in
{
  programs.zsh = {
    enable = true;
    autocd = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    initContent = ''
      source ${catppuccin-zsh-syntax-highlighting}/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh
      eval $(opam env)
      export PATH=~/.local/bin:/usr/local/smlnj/bin:$PATH
    '';
    shellAliases = {
      cp = "xcp";
      q = "exit";
      n = "nvim";
    } // (
      let servers = [ "ra" "amun" "set" "anubis" "seshat" "hathor" "thoth" "maat" "sekhmet" ];
      in
      builtins.listToAttrs (map
        (server: {
          name = server;
          value = "ssh fady@${server}.cs.uchicago.edu";
        })
        servers)
    );
  };

}
