{ ... }:

{
  programs.tmux = {
    enable = true;
    escapeTime = 0;
    extraConfig = ''
      set -g default-terminal "screen-255color"

      set -sg escape-time 0

      set -g prefix C-a
      unbind C-b
      bind-key C-a send-prefix

      unbind %
      bind | split-window -h

      unbind '"'
      bind - split-window -v

      unbind r
      bind r source-file ~/.tmux.conf

      bind -r h resize-pane -L 5
      bind -r j resize-pane -D 5
      bind -r k resize-pane -U 5
      bind -r l resize-pane -R 5

      bind -r m resize-pane -Z

      # set -g mouse on

      set-window-option -g mode-keys vi

      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-selection

      unbind -T copy-mode-vi MouseDragEnd1Pane

      # tpm plugin
      set -g @plugin 'tmux-plugins/tpm'

      # list of tmux plugins
      set -g @plugin 'christoomey/vim-tmux-navigator'
      set -g @plugin 'tmux-plugins/tmux-resurrect' # persist tmux sessions after computer restart
      set -g @plugin 'tmux-plugins/tmux-continuum' # automatically saves sessions for you every 15 minutes

      set -g @resurrect-capture-pane-contents 'on'
      set -g @continuum-restore 'on'

      # Initialize TMUX plugin manager
      run '~/.tmux/plugins/tpm/tpm'
    '';
  };
}
