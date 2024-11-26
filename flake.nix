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
    nixvim = {
        url = "github:nix-community/nixvim";
        # If using a stable channel you can use `url = "github:nix-community/nixvim/nixos-<version>"`
        inputs.nixpkgs.follows = "nixpkgs";
    };
    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, nixvim, mac-app-util }:
  let
    configuration = {pkgs, ... }: {
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
        programs.zsh.enable = true;
        nixpkgs.config.allowUnfree = true;

        environment.systemPackages = with pkgs; [
        duf
        ncdu
        subversion
        ccls
        python312
    ];

	homebrew = {
          enable = true;
          onActivation.cleanup = "uninstall";
          brews = [
            "mongodb/brew/mongodb-community"
            "redis"
          ];
          casks = [
            "font-fira-code-nerd-font"
            "google-chrome"
            "slack"
            "maccy"
            "anki"
            
          ];
          taps = [];

          masApps = {
          };

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
        };
        # a finder that tells me what I want to know and lets me work
        finder = {
          AppleShowAllExtensions = true;
          ShowPathbar = true;
          FXEnableExtensionChangeWarning = false;
        };
    };
    

    };

    homeconfig = {pkgs, ...}: {
            # this is internal compatibility configuration 
            # for home-manager, don't change this!
            home.stateVersion = "23.05";
            # Let home-manager install and manage itself.
            programs.home-manager.enable = true;

            home.packages = with pkgs; [];

            home.sessionVariables = {
                EDITOR = "vim";
            };
            home.file.".vimrc".source = ./vim_configuration;

            programs.zsh = {
                enable = true;
                shellAliases = {
                    switch = "darwin-rebuild switch --flake ~/.config/nix";
                    uclinux = "ssh zelshahawy@linux.cs.uchicago.edu";
                    upd = "vim ~/.config/nix/flake.nix";
                };
                initExtra = ''
                    prompt_context(){} # removed computer name

                    # svn set up

                    prompt_svn() {
                        local rev branch
                        if in_svn; then
                            rev=$(svn_get_rev_nr)
                            branch=$(svn_get_branch_name)
                            if [ `svn_dirty_choose_pwd 1 0` -eq 1 ]; then
                                prompt_segment yellow black
                                echo -n "$rev@$branch"
                                echo -n "±"
                            else
                                prompt_segment green black
                                echo -n "$rev@$branch"
                            fi
                        fi
                    }

                    build_prompt() {
                        RETVAL=$?
                        prompt_status
                        prompt_context
                        prompt_dir
                        prompt_git
                        prompt_svn
                        prompt_end
                    }

                    export PATH="/run/current-system/sw/bin/:$PATH" 
                                                                    '';
            };

            # A bunch of programs enabled/disabled using home maanager with no extra config
            programs.firefox.enable = false;
            programs.eza.enable = true;
            programs.go.enable = true;
            programs.lf.enable = true;
            programs.fastfetch.enable = true;
            programs.bat.enable = true;
            programs.zsh.syntaxHighlighting.enable = true;
            programs.zsh.autosuggestion.enable = true;
            programs.vscode.enable = true;
            programs.tealdeer.enable = true;

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
                plugins = ["git" "svn" "you-should-use"];
                theme = "agnoster";
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
