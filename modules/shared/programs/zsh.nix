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
      export PATH="/run/current-system/sw/bin/:$PATH"
      export PATH="$PATH:$HOME/go/bin"
      export PATH="$HOME/.cargo/bin:$PATH"
      export PATH="$HOME/.local/bin:$PATH"
      export TERM="xterm-256color"

    '';
    shellAliases = {
      cp = "xcp";
      q = "exit";
      n = "nvim";
      uclinux = "ssh zelshahawy@linux.cs.uchicago.edu";
    } // (
      let servers = [ "ra" "amun" "set" "anubis" "seshat" "hathor" "thoth" "maat" "sekhmet" ];
      in
      builtins.listToAttrs (map
        (server: {
          name = server;
          value = "ssh zelshahawy@${server}.cs.uchicago.edu";
        })
        servers)
    );
    plugins = [
      {
        name = "you-should-use";
        src = pkgs.fetchFromGitHub {
          owner = "MichaelAquilina";
          repo = "zsh-you-should-use";
          rev = "f13d39a1ae84219e4ee14e77d31bb774c91f2fe3";
          hash = "sha256-+3iAmWXSsc4OhFZqAMTwOL7AAHBp5ZtGGtvqCnEOYc0=";
        };
      }
    ];
  };

}
