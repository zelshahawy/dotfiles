{ pkgs, ... }:
{
  programs.helix = {
    enable = true;
    settings = {
      theme = "gruvbox_dark_hard";

      editor = {
        line-number = "relative";
        cursorline = true;
        color-modes = true;
        true-color = true;
        bufferline = "multiple";
        rulers = [
          80
          100
        ];
        scrolloff = 8;
        idle-timeout = 50;
        completion-trigger-len = 1;
        auto-format = true;
        auto-pairs = true;

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        file-picker = {
          hidden = false;
          git-ignore = true;
        };

        statusline = {
          left = [
            "mode"
            "spinner"
            "version-control"
            "file-name"
            "file-modification-indicator"
          ];
          center = [ ];
          right = [
            "diagnostics"
            "selections"
            "register"
            "position"
            "file-encoding"
            "file-line-ending"
            "file-type"
          ];
          mode = {
            normal = "NORMAL";
            insert = "INSERT";
            select = "SELECT";
          };
        };

        lsp = {
          enable = true;
          display-messages = true;
          display-inlay-hints = true;
          auto-signature-help = true;
          snippets = true;
        };

        indent-guides = {
          render = true;
          character = "╎";
          skip-levels = 1;
        };
        soft-wrap = {
          enable = true;
          wrap-indicator = "↪ ";
        };
        gutters = [
          "diagnostics"
          "spacer"
          "line-numbers"
          "spacer"
          "diff"
        ];
        smart-tab.enable = true;

        auto-save = {
          focus-lost = true;
          after-delay = {
            enable = true;
            timeout = 3000;
          };
        };
      };

      keys.normal = {
        space.space = "file_picker";
        space.w = [
          ":format"
          ":write"
        ];
        space.f = ":format";
        space.q = ":quit";
        space.x = ":buffer-close";
        esc = [
          "collapse_selection"
          "keep_primary_selection"
        ];
        "C-d" = [
          "half_page_down"
          "align_view_center"
        ];
        "C-u" = [
          "half_page_up"
          "align_view_center"
        ];
        "A-j" = "move_line_down";
        "A-k" = "move_line_up";
        "C-h" = "jump_view_left";
        "C-l" = "jump_view_right";
        "C-j" = "jump_view_down";
        "C-k" = "jump_view_up";
        "K" = "hover";
      };
    };

    themes = { };

    languages = {
      language-server = {
        rust-analyzer.config = {
          check.command = "clippy";
          cargo.features = "all";
          procMacro.enable = true;
          inlayHints = {
            closingBraceHints.minLines = 10;
            closureReturnTypeHints.enable = "with_block";
            lifetimeElisionHints.enable = "skip_trivial";
          };
        };

        gopls.config = {
          gofumpt = true;
          staticcheck = true;
          usePlaceholders = true;
          analyses = {
            unusedparams = true;
            nilness = true;
            shadow = true;
          };
          hints = {
            assignVariableTypes = true;
            compositeLiteralFields = true;
            constantValues = true;
            functionTypeParameters = true;
            parameterNames = true;
            rangeVariableTypes = true;
          };
        };

        pyright = {
          command = "pyright-langserver";
          args = [ "--stdio" ];
          config.python.analysis = {
            typeCheckingMode = "basic";
            autoImportCompletions = true;
          };
        };
        ruff = {
          command = "ruff";
          args = [ "server" ];
        };

        nixd.config.nixd.formatting.command = [ "nixfmt" ];
      };

      language = [
        {
          name = "rust";
          auto-format = true;
          language-servers = [ "rust-analyzer" ];
        }
        {
          name = "go";
          auto-format = true;
          language-servers = [ "gopls" ];
        }
        {
          name = "python";
          auto-format = true;
          language-servers = [
            "pyright"
            "ruff"
          ];
          formatter = {
            command = "ruff";
            args = [
              "format"
              "-"
            ];
          };
        }
        {
          name = "nix";
          auto-format = true;
          language-servers = [ "nixd" ];
          formatter.command = "nixfmt";
        }
        {
          name = "bash";
          auto-format = true;
          formatter = {
            command = "shfmt";
            args = [
              "-i"
              "2"
            ];
          };
        }
        {
          name = "lua";
          auto-format = true;
          formatter = {
            command = "stylua";
            args = [ "-" ];
          };
        }
        {
          name = "toml";
          auto-format = true;
          formatter = {
            command = "taplo";
            args = [
              "format"
              "-"
            ];
          };
        }
        {
          name = "json";
          auto-format = true;
          formatter = {
            command = "prettier";
            args = [
              "--parser"
              "json"
            ];
          };
        }
        {
          name = "yaml";
          auto-format = true;
          formatter = {
            command = "prettier";
            args = [
              "--parser"
              "yaml"
            ];
          };
        }
        {
          name = "markdown";
          auto-format = true;
          language-servers = [ "marksman" ];
          formatter = {
            command = "prettier";
            args = [
              "--parser"
              "markdown"
            ];
          };
        }
        {
          name = "typescript";
          auto-format = true;
          formatter = {
            command = "prettier";
            args = [
              "--parser"
              "typescript"
            ];
          };
        }
        {
          name = "javascript";
          auto-format = true;
          formatter = {
            command = "prettier";
            args = [
              "--parser"
              "babel"
            ];
          };
        }
      ];
    };

    extraPackages = with pkgs; [
      rust-analyzer
      gopls
      delve
      pyright
      ruff
      nixd
      nixfmt-rfc-style
      typescript-language-server
      vscode-langservers-extracted
      prettier
      bash-language-server
      shellcheck
      shfmt
      lua-language-server
      stylua
      clang-tools
      marksman
      taplo
      yaml-language-server
      dockerfile-language-server-nodejs
    ];
  };
}
