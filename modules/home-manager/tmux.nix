{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    extraConfig = ''
      set -s escape-time 10
      set -sg repeat-time 600

      set -g base-index 1
      set -g pane-base-index 1
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on

      set-option -g status-interval 5
      set-option -g automatic-rename on
      set-option -g automatic-rename-format '#{b:pane_current_path}'

      set -g @continuum-restore 'on'
      set -g @continuum-save-interval '1'
      set -g @continuum-boot 'on'
      set -g @resurrect-dir "${config.home.homeDirectory}/.tmux/resurrect"

      bind r source-file ${config.home.homeDirectory}/.config/tmux/tmux.conf

      unbind %
      bind i split-window -h -c "#{pane_current_path}"

      unbind '"'
      bind - split-window -v -c "#{pane_current_path}"

      unbind c
      bind t new-window -c "#{pane_current_path}"

      bind -n M-h select-pane -L
      bind -n M-j select-pane -D
      bind -n M-k select-pane -U
      bind -n M-l select-pane -R

      bind -r h resize-pane -L 5
      bind -r j resize-pane -D 5
      bind -r k resize-pane -U 5
      bind -r l resize-pane -R 5

      bind -r m resize-pane -Z

      # set -g mouse on

      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-selection

      unbind -T copy-mode-vi MouseDragEnd1Pane
    '';
    keyMode = "vi";
    plugins = with pkgs; [
      tmuxPlugins.resurrect
      tmuxPlugins.continuum
    ];
    shell = "${pkgs.zsh}/bin/zsh";
    shortcut = "Space";
  };
}
