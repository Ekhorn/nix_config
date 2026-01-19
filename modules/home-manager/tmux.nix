{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    extraConfig = ''
      set -s exit-empty off
      set -s escape-time 10
      set -sg repeat-time 600

      set -g base-index 1
      set -g pane-base-index 1
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on

      set-option -g status-interval 5
      set-option -g automatic-rename on
      set-option -g automatic-rename-format '#{b:pane_current_path}'

      bind r source-file ${config.home.homeDirectory}/.config/tmux/tmux.conf

      unbind %
      bind i split-window -h -c "#{pane_current_path}"

      unbind '"'
      bind - split-window -v -c "#{pane_current_path}"

      unbind c
      bind t new-window -c "#{pane_current_path}"

      bind -n C-h select-pane -L
      bind -n C-j select-pane -D
      bind -n C-k select-pane -U
      bind -n C-l select-pane -R

      bind -r h resize-pane -L 5
      bind -r j resize-pane -D 5
      bind -r k resize-pane -U 5
      bind -r l resize-pane -R 5
      bind -r m resize-pane -Z
    '';
    keyMode = "vi";
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig =
          let
            dir = "${config.home.homeDirectory}/.tmux/resurrect";
          in
          ''
            set -g @resurrect-capture-pane-contents 'on'
            set -g @resurrect-dir "${dir}"
            set -g @resurrect-hook-post-save-all 'sed -i "s|/nix/store/[^/]*/bin/||g" ${dir}/last'
          '';
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          # set -g @continuum-restore 'on'
          set -g @continuum-save-interval '5'
        '';
      }
    ];
    shell = "${pkgs.zsh}/bin/zsh";
    shortcut = "Space";
  };
}
