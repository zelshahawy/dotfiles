{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, mac-app-util }:
    let
      configuration = { pkgs, ... }: {
        services.nix-daemon.enable = true;
        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";

        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility. please read the changelog
        # before changing: `darwin-rebuild changelog`.
        system.stateVersion = 4;

        # The platform the configuration will be used on.
        # If you're on an Intel system, replace with "x86_64-darwin"
        nixpkgs.hostPlatform = "aarch64-darwin";

        # Declare the user that will be running `nix-darwin`.
        users.users.ziadelshahawy = {
          name = "ziadelshahawy";
          home = "/Users/ziadelshahawy";
        };

        # Create /etc/zshrc that loads the nix-darwin environment.
        programs.zsh = {
          enable = true;
        };

        nixpkgs.config.allowUnfree = true;

        environment.systemPackages = with pkgs; [
          ncdu
          subversion
          python312
          gopls
          mas
          python312Packages.python-lsp-server
          nurl
          nil
          nixpkgs-fmt
          llvmPackages_19.clang-unwrapped
          yarn
          nodejs_23
        ];

        homebrew = {
          enable = true;
          onActivation = {
            autoUpdate = true;
            cleanup = "uninstall";
            upgrade = true;
          };
          brews = [
            "mongodb/brew/mongodb-community"
            "redis"
          ];
          casks = [
            "font-fira-code-nerd-font"
            "google-chrome"
            "maccy"
            "anki"
            "vmware-fusion"
            "slack"
            "obsidian"
            "microsoft-powerpoint"
            "postman"
            "zoom"
          ];
          taps = [
            "homebrew/services"
          ];

          masApps = { };
        };

        security.pam.enableSudoTouchIdAuth = true;

        system.defaults = {
          # minimal dock
          dock = {
            autohide = true;
            orientation = "bottom";
            show-process-indicators = false;
            show-recents = false;
            static-only = true;
            magnification = false;
          };
          # a finder that tells me what I want to know and lets me work
          finder = {
            AppleShowAllExtensions = true;
            ShowPathbar = true;
            FXEnableExtensionChangeWarning = false;
            AppleShowAllFiles = false; # Use when want to see hidden
          };
          trackpad = {
            # Clicking = true;
            # ActuationStrength = 0;
          };
        };
        nix.gc = {
          automatic = true;
          options = "--delete-older-than 15d";
        };
      };

      homeconfig = { pkgs, ... }: {
        # this is internal compatibility configuration 
        # for home-manager, don't change this!
        home.stateVersion = "23.05";
        # Let home-manager install and manage itself.
        programs.home-manager.enable = true;

        home.packages = with pkgs; [ ];

        home.sessionVariables = {
          EDITOR = "nvim";
        };
        home.file.".vimrc".source = ./vim_configuration;

        home.file."./.config/nvim/" = {
          source = ./nvim-config;
          recursive = true;
        };

        programs.zsh = {
          enable = true;
          shellAliases = {
            switch = "darwin-rebuild switch --flake ~/.config/nix";
            uclinux = "sshk zelshahawy@linux.cs.uchicago.edu";
            upd = "nvim ~/.config/nix/flake.nix";
            e = "exit";
            sshk = "kitty +kitten ssh";
            c = "clear";
          } // (
            let servers = [ "ra" "amun" "set" "anubis" "seshat" "hathor" "thoth" "maat" ];
            in
            builtins.listToAttrs (map
              (server: {
                name = server;
                value = "sshk zelshahawy@${server}.cs.uchicago.edu";
              })
              servers)
          );
          initExtra = builtins.readFile ./zsh_extra;
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

        # A bunch of programs enabled/disabled using home maanager with no extra config
        programs.firefox.enable = false;
        programs.eza.enable = true;
        programs.go.enable = true;
        programs.lf.enable = true;
        programs.fastfetch.enable = true;
        programs.zsh.syntaxHighlighting.enable = true;
        programs.zsh.autosuggestion.enable = true;
        programs.vscode.enable = true;
        programs.tealdeer.enable = true;

        programs.tmux = {
          enable = true;
          mouse = true;
          extraConfig = builtins.readFile ./tmux_extra;
        };

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

        programs.zsh.oh-my-zsh = {
          enable = true;
          plugins = [ "git" "svn" ];
          theme = "agnoster";
        };

        programs.neovim = {
          enable = true;
        };

        programs.kitty = {
          enable = true;
          font = {
            size = 15;
            name = "FiraCode Nerd Font Mono Light";
          };
          themeFile = "Dracula";
        };

        programs.bat = {
          enable = true;
          themes = {
            solarized-light = {
              src = pkgs.fetchFromGitHub {
                owner = "braver";
                repo = "Solarized"; # Bat uses sublime syntax for its themes
                rev = "82c9ae47b11a547c3c55d2d0fb5a96ea7bec035f";
                sha256 = "sha256-K0LevG89BxbGajxWWycunK+pwH3JlJSfb+23bM54uYk=";
              };
              file = "Solarized (light).sublime-color-scheme";
            };
          };
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
      };


    in
    {
      darwinConfigurations."Ziads-MacBook-Air" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          mac-app-util.darwinModules.default
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.verbose = true;

            home-manager.sharedModules = [
              mac-app-util.homeManagerModules.default
            ];

            home-manager.users.ziadelshahawy = homeconfig;
          }
        ];
      };
    };
}

