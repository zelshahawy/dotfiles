{ ... }:

{
  services.aerospace = {
    enable = true;
    settings = {
      after-startup-command = [
        "exec-and-forget sketchybar"
      ];

      enable-normalization-flatten-containers = true;
      enable-normalization-opposite-orientation-for-nested-containers = true;

      accordion-padding = 30;

      default-root-container-layout = "tiles";
      default-root-container-orientation = "auto";

      key-mapping.preset = "qwerty";

      on-focused-monitor-changed = [ "move-mouse monitor-lazy-center" ];

      gaps = {
        inner.horizontal = 10;
        inner.vertical = 10;
        outer.left = 10;
        outer.bottom = 10;
        outer.right = 10;
        outer.top = 40;
      };

      mode.main.binding = {
        # Focus window
        alt-h = "focus left";
        alt-j = "focus down";
        alt-k = "focus up";
        alt-l = "focus right";

        # Move window
        alt-shift-h = "move left";
        alt-shift-j = "move down";
        alt-shift-k = "move up";
        alt-shift-l = "move right";

        # Focus monitor
        alt-ctrl-k = "focus-monitor up";
        alt-ctrl-j = "focus-monitor down";

        # Move window to monitor
        alt-ctrl-shift-k = [
          "move-node-to-monitor up"
          "focus-monitor up"
        ];
        alt-ctrl-shift-j = [
          "move-node-to-monitor down"
          "focus-monitor down"
        ];

        # Rotate tree
        alt-r = "layout tiles horizontal vertical";

        # Toggle fullscreen
        alt-f = "fullscreen";

        # Float / unfloat window
        alt-t = "layout floating tiling";

        # Toggle split orientation
        alt-e = "layout tiles horizontal vertical";

        # Balance windows
        alt-shift-0 = "balance-sizes";

        # Move window to workspace and focus
        alt-shift-1 = [
          "move-node-to-workspace 1"
          "workspace 1"
          "exec-and-forget sketchybar --trigger windows_on_spaces"
        ];
        alt-shift-2 = [
          "move-node-to-workspace 2"
          "workspace 2"
          "exec-and-forget sketchybar --trigger windows_on_spaces"
        ];
        alt-shift-3 = [
          "move-node-to-workspace 3"
          "workspace 3"
          "exec-and-forget sketchybar --trigger windows_on_spaces"
        ];
        alt-shift-4 = [
          "move-node-to-workspace 4"
          "workspace 4"
          "exec-and-forget sketchybar --trigger windows_on_spaces"
        ];
        alt-shift-5 = [
          "move-node-to-workspace 5"
          "workspace 5"
          "exec-and-forget sketchybar --trigger windows_on_spaces"
        ];
        alt-shift-6 = [
          "move-node-to-workspace 6"
          "workspace 6"
          "exec-and-forget sketchybar --trigger windows_on_spaces"
        ];
        alt-shift-7 = [
          "move-node-to-workspace 7"
          "workspace 7"
          "exec-and-forget sketchybar --trigger windows_on_spaces"
        ];
        alt-shift-8 = [
          "move-node-to-workspace 8"
          "workspace 8"
          "exec-and-forget sketchybar --trigger windows_on_spaces"
        ];
        alt-shift-9 = [
          "move-node-to-workspace 9"
          "workspace 9"
          "exec-and-forget sketchybar --trigger windows_on_spaces"
        ];

        # Focus workspace
        alt-tab = "workspace-back-and-forth";

        alt-1 = "workspace 1";
        alt-2 = "workspace 2";
        alt-3 = "workspace 3";
        alt-4 = "workspace 4";
        alt-5 = "workspace 5";
        alt-6 = "workspace 6";
        alt-7 = "workspace 7";
        alt-8 = "workspace 8";
        alt-9 = "workspace 9";

        # Service commands
        alt-shift-semicolon = "mode service";
      };

      mode.service.binding = {
        esc = [
          "reload-config"
          "mode main"
        ];
        r = [
          "flatten-workspace-tree"
          "mode main"
        ];
        backspace = [
          "close-all-windows-but-current"
          "mode main"
        ];
      };

      # App-specific rules
      on-window-detected = [
        # App to workspace assignments
        {
          "if".app-id = "company.thebrowser.Browser";
          run = "move-node-to-workspace 1";
        }
        {
          "if".app-id = "com.github.wez.wezterm";
          run = "move-node-to-workspace 2";
        }
        {
          "if".app-id = "com.tinyspeck.slackmacgap";
          run = "move-node-to-workspace 5";
        }
        {
          "if".app-id = "com.spotify.client";
          run = "move-node-to-workspace 6";
        }
        # Floating windows
        {
          "if".app-id = "com.apple.archiveutility";
          run = "layout floating";
        }
        {
          "if".app-id = "com.apple.Music";
          run = "layout floating";
        }
        {
          "if".app-id = "com.raycast.macos";
          run = "layout floating";
        }
        {
          "if".app-id = "eu.exelban.Stats";
          run = "layout floating";
        }
        {
          "if".app-id = "com.apple.calculator";
          run = "layout floating";
        }
        {
          "if".app-id = "com.apple.systempreferences";
          run = "layout floating";
        }
        {
          "if" = {
            app-id = "com.apple.Safari";
            window-title-regex-substring = "^(General|(Tab|Password|Website|Extension)s|AutoFill|Se(arch|curity)|Privacy|Advance)$";
          };
          run = "layout floating";
        }
        {
          "if" = {
            app-id = "com.apple.finder";
            window-title-regex-substring = "(Co(py|nnect)|Move|Info|Pref)";
          };
          run = "layout floating";
        }
      ];

      # Sketchybar integration callbacks
      exec-on-workspace-change = [
        "/bin/bash"
        "-c"
        "/run/current-system/sw/bin/sketchybar --trigger aerospace_workspace_change FOCUSED_WORKSPACE=$AEROSPACE_FOCUSED_WORKSPACE && /run/current-system/sw/bin/sketchybar --trigger windows_on_spaces"
      ];

      # Workspace to monitor assignment
      # Aerospace: Monitor 1 = LC34G55T (external), Monitor 2 = Built-in (main)
      workspace-to-monitor-force-assignment = {
        "1" = 2;
        "2" = 2;
        "3" = 2;
        "4" = 2;
        "5" = 2;
        "6" = 2;
        "7" = 2;
        "8" = 1;
        "9" = 1;
        "10" = 1;
      };
    };
  };
}
