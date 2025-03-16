{ pkgs, ... }:

{
  # Home Manager internal state version.
  home.stateVersion = "23.05";

  # Enable Home Manager self-management.
  programs.home-manager.enable = true;
  # Additional packages for the user.
  home.packages = with pkgs; [ ];

  # Session environment variables.
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.eza.enable = true;
  programs.go.enable = true;
  programs.lf.enable = true;
  programs.fastfetch.enable = true;
  programs.zsh.syntaxHighlighting.enable = true;
  programs.zsh.autosuggestion.enable = true;
  programs.tealdeer.enable = true;

  # User dotfiles.
  home.file.".vimrc".source = ../etc/vim_configuration;
  home.file."./.config/nvim/" = {
    source = ../etc/nvim-config;
    recursive = true;
  };

  # zsh configuration with shell aliases.
  programs.zsh = {
    enable = true;
    shellAliases = {
      switch = "darwin-rebuild switch --flake ~/.config/nix";
      uclinux = "ssh zelshahawy@linux.cs.uchicago.edu";
      e = "exit";
      sshk = "kitty +kitten ssh"; # Currently deprecated.
      c = "clear";
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

    initExtra = builtins.readFile ../etc/zsh_extra;
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

  # tmux configuration.
  programs.tmux = {
    enable = true;
    mouse = true;
    extraConfig = builtins.readFile ../etc/tmux_extra;
  };

  # Git configuration.
  programs.git = {
    enable = true;
    userName = "Ziad Elshahawy";
    userEmail = "ziadelshahawygit@gmail.com";
    ignores = [ ".DS_Store" "*.lock" ];
    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };
  };

  # oh-my-zsh configuration.
  programs.zsh.oh-my-zsh = {
    enable = true;
    plugins = [ "git" "svn" ];
    custom = "$HOME/.config/nix/etc/oh-my-zsh/themes/";
  };

  # Enable neovim.
  programs.neovim.enable = true;

  # kitty terminal configuration.
  programs.kitty = {
    enable = true;
    package = pkgs.kitty.overrideAttrs (oldAttrs: {
      # https://github.com/NixOS/nixpkgs/issues/388020
      doInstallCheck = false;
    });
    font = {
      size = 19;
      name = "FiraCode Nerd Font Mono Light";
    };
    themeFile = "Catppuccin-Mocha";
    settings = {
      background_blur = 1;
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      command_timeout = 1000;
    };
  };

  # alacritty terminal configuration.
  programs.alacritty = {
    enable = true;
    settings = {
      general =
        let
          catppuccinAlacritty = builtins.fetchGit {
            url = "https://github.com/catppuccin/alacritty.git";
            rev = "f6cb5a5c2b404cdaceaff193b9c52317f62c62f7";
          };
        in
        {
          live_config_reload = true;
          import = [ "${catppuccinAlacritty}/catppuccin-mocha.toml" ];
        };
      terminal.shell = {
        args = [ "-l" "-c" "tmux attach || tmux -2" ];
        program = "${pkgs.zsh}/bin/zsh";
      };
      selection.save_to_clipboard = true;
      cursor = {
        blink_interval = 400;
        thickness = 0.15;
        unfocused_hollow = true;
        style = { blinking = "Always"; shape = "Beam"; };
      };
      font = {
        size = 19.0;
        normal = { family = "FiraCode Nerd Font Mono Light"; };
      };
      window = {
        decorations = "Buttonless";
        opacity = 0.7;
        option_as_alt = "OnlyLeft";
        blur = true;
        padding = { x = 5; y = 2; };
      };
    };
  };

  # bat configuration.
  programs.bat = {
    enable = true;
    syntaxes = {
      gleam = {
        src = pkgs.fetchFromGitHub {
          owner = "molnarmark";
          repo = "sublime-gleam";
          rev = "2e761cdb1a87539d827987f997a20a35efd68aa9";
          hash = "sha256-Zj2DKTcO1t9g18qsNKtpHKElbRSc9nBRE2QBzRn9+qs=";
        };
        file = "syntax/gleam.sublime-syntax";
      };
    };
  };

  programs.vscode = {
    enable = true;
    profiles.default.userSettings = {
      "editor.formatOnSave" = true;
      "workbench.colorTheme" = "Catppuccin Mocha";
    };
  };
}

