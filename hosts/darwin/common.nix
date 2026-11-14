{ config
, pkgs
, hostName
, lib
, ...
}:
{
  imports = [
    ../../modules/darwin
  ];

  networking.hostName = lib.mkForce hostName;

  system.activationScripts.setHostName.text = ''
    /usr/sbin/scutil --set HostName "${hostName}"
    /usr/sbin/scutil --set LocalHostName "${hostName}"
    /usr/sbin/scutil --set ComputerName "${hostName}"
  '';

  system = {
    primaryUser = "ziadelshahawy";
    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    # Set Git commit hash for darwin-version.
    configurationRevision = config.rev or config.dirtyRev or null;

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };

    defaults = {
      # minimal dock
      dock = {
        autohide = true;
        orientation = "bottom";
        show-process-indicators = false;
        show-recents = false;
        static-only = true;
      };
      finder = {
        AppleShowAllExtensions = true;
        ShowPathbar = true;
        AppleShowAllFiles = true;
        FXEnableExtensionChangeWarning = false;
      };
    };
  };

  environment = {
    enableAllTerminfo = true;
    etc."pam.d/sudo_local".text = ''
      # Managed by Nix Darwin
      auth       optional       ${pkgs.pam-reattach}/lib/pam/pam_reattach.so ignore_ssh
      auth       sufficient     pam_tid.so
    '';
  };

  fonts.packages = with pkgs.nerd-fonts; [
    caskaydia-cove
    recursive-mono
  ];

  security.pam.services.sudo_local.touchIdAuth = true;

  services.openssh = {
    enable = true;

    extraConfig = ''
      PubkeyAuthentication yes
      PasswordAuthentication no
      KbdInteractiveAuthentication no
      PermitRootLogin no

      AllowUsers ziadelshahawy@100.64.0.0/10 ziadelshahawy@fd7a:115c:a1e0::/48
    '';
  };

  nix = {
    enable = true;
    settings = {
      experimental-features = "nix-command flakes";
      trusted-users = [ "ziadelshahawy" ];
    };

    package = pkgs.nixVersions.stable;
    gc.automatic = true;
    extraOptions = ''
      extra-platforms = x86_64-darwin aarch64-darwin
    '';
    # linux-builder.enable = true;
  };

  programs = {
    # Create /etc/zshrc that loads the nix-darwin environment.
    zsh.enable = true;
    bash.enable = true;
  };

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config = {
    allowUnfree = true;
    problems.handlers = {
      yaegi.broken = "warn";
      pylsp-mypy.broken = "warn";
    };
  };

  nixpkgs.overlays = [
    # Work around the OpenCode 2.2.5 dependency hash mismatch on Apple Silicon.
    (final: prev: {
      opencode =
        if
          prev.stdenv.hostPlatform.system == "aarch64-darwin"
          && prev.opencode.version == "2.2.5"
          && prev.opencode.node_modules.outputHash == "sha256-xfOVcw1+waLVNhFDwzOtzxrUSQEogvn88YomydOlhwc="
        then
          prev.opencode.overrideAttrs
            (old: {
              node_modules = old.node_modules.overrideAttrs (_: {
                outputHash = "sha256-dIveiaiPFGSItwLyeMuPDxTE9gpvvnlTCB/+nG24qCc=";
              });
            })
        else
          prev.opencode;
    })
    # xcp 0.24.9 renamed these tests, so nixpkgs' Darwin skip flags no longer match.
    (final: prev: {
      xcp =
        if prev.stdenv.hostPlatform.isDarwin && prev.xcp.version == "0.24.9" then
          prev.xcp.overrideAttrs
            (old: {
              checkFlags = (old.checkFlags or [ ]) ++ [
                "--skip=test_socket_file::test_case_1_test_with_parallel_file_driver"
                "--skip=test_sockets_dir::test_case_1_test_with_parallel_file_driver"
              ];
            })
        else
          prev.xcp;
    })
    # Bump only sketchybar without updating the whole nixpkgs input
    (final: prev: {
      sketchybar = prev.sketchybar.overrideAttrs (old: rec {
        version = "2.24.1";
        src = prev.fetchFromGitHub {
          owner = "FelixKratz";
          repo = "SketchyBar";
          rev = "v${version}";
          hash = "sha256-fEbVzafjFTigR7TjQ41gOnDpk6S4B8qCwpz890ZNgwE=";
        };
      });
    })
    (
      final: prev:
        let
          patchPy =
            py:
            py.override (old: {
              packageOverrides = final.lib.composeExtensions (old.packageOverrides or (_: _: { })) (
                pyfinal: pyprev: {
                  pylsp-mypy = pyprev.pylsp-mypy.overridePythonAttrs (_: {
                    doCheck = false; # tests are stale vs. current mypy
                  });
                }
              );
            });
        in
        {
          python3 = patchPy prev.python3;
          python313 = patchPy prev.python313; # the log says python3.13
          python3Packages = final.python3.pkgs; # keep the alias in sync
          python313Packages = final.python313.pkgs;
        }
    )
  ];
}
