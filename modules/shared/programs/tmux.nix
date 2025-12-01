{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor "mocha"
          set -g @catppuccin_status_left_separator "█"
          set -g @catppuccin_status_right_separator "█"
          set -g @catppuccin_status_background "none"
          set -g @catppuccin_directory_text " #{s|$HOME|~|;s|/.*/|/…/|:pane_current_path}"

          set -ogq @catppuccin_window_text " #W at #{b:pane_current_path}"
          set -ogq @catppuccin_window_current_text " #W at #{b:pane_current_path}"
        '';
      }
      vim-tmux-navigator
      t-smart-tmux-session-manager
      resurrect
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '15'
        '';
      }
      # extrakto
    ];

    baseIndex = 1;
    escapeTime = 0;
    historyLimit = 1000000;
    mouse = true;
    shell = "$SHELL";
    keyMode = "vi";

    extraConfig = ''
      set -g status-left ""
      set -g status-right "#{E:@catppuccin_status_directory}"
      set -agF status-right "#{E:@catppuccin_status_session}"

      setw -g pane-base-index 1
      setw -g automatic-rename on

      set -g detach-on-destroy off  # do not exit tmux when closing a session
      set -g renumber-windows on    # renumber all windows when any window is closed
      set -g set-clipboard on       # use system clipboard
      set -g status-interval 2      # update status every 2 seconds
      set -g status-left-length 200
      set -g status-position top    # macOS / darwin style
      set -g default-command /bin/zsh

      set -g prefix2 C-a
      bind C-a send-prefix -2

      # reload configuration
      bind r source-file ~/.config/tmux/tmux.conf

      # TERM / RGB / features
      set-option -g default-terminal 'tmux-256color'
      set-option -ag terminal-overrides ",xterm-256color:RGB"
      set-option -ag terminal-overrides ",tmux-256color:RGB"
      set-option -ag terminal-overrides ",ghostty:RGB"

      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'  # undercurl support
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'

      set -as terminal-features ',*:usstyle'      # undercurl style support
      set -as terminal-features ',ghostty:RGB'    # enable RGB colors for Ghostty

      set-option -g focus-events on

      unbind v
      unbind %
      bind 'v' split-window -c '#{pane_current_path}' -h
      bind '"' split-window -c '#{pane_current_path}' -v
      bind 'h' split-window -c '#{pane_current_path}' -v
      bind c new-window -c '#{pane_current_path}'
      bind g new-window -n '' -c "#{pane_current_path}" lazygit

      bind Enter copy-mode
      bind -T copy-mode-vi v  send -X begin-selection
      bind -T copy-mode-vi C-v send -X rectangle-toggle
      bind -T copy-mode-vi y  send -X copy-selection-and-cancel
      bind -T copy-mode-vi H  send -X start-of-line
      bind -T copy-mode-vi L  send -X end-of-line

      bind-key x kill-pane    # skip "kill-pane 1? (y/n)" prompt
    '';
  };
}

