let
  swapPane = direction: [
    "workspace::SwapPaneInDirection"
    direction
  ];
in
[
  {
    bindings = {
      alt-h = "workspace::ToggleHelixMode";
      ctrl-t = "workspace::NewTerminal";
      # matching helix
      ctrl-h = "workspace::ActivatePaneLeft";
      ctrl-j = "workspace::ActivatePaneDown";
      ctrl-k = "workspace::ActivatePaneUp";
      ctrl-l = "workspace::ActivatePaneRight";
      # matching firefox
      ctrl-w = "pane::CloseActiveItem";
      ctrl-pageup = "pane::ActivatePrevItem";
      ctrl-pagedown = "pane::ActivateNextItem";
      shift-pageup = "pane::SwapItemLeft";
      shift-pagedown = "pane::SwapItemRight";
      # matching tmux
      "ctrl-space i" = "pane::SplitRight";
      "ctrl-space -" = "pane::SplitDown";
      "ctrl-space h" = "vim::ResizePaneLeft";
      "ctrl-space j" = "vim::ResizePaneDown";
      "ctrl-space k" = "vim::ResizePaneUp";
      "ctrl-space l" = "vim::ResizePaneRight";
      "ctrl-space m" = "workspace::ToggleZoom";
      "ctrl-space shift-h" = swapPane "Left";
      "ctrl-space shift-j" = swapPane "Down";
      "ctrl-space shift-k" = swapPane "Up";
      "ctrl-space shift-l" = swapPane "Right";
      # alternative tmux resize to auto-repeat; zed sequences can't repeat like tmux -r
      "alt-shift-h" = "vim::ResizePaneLeft";
      "alt-shift-j" = "vim::ResizePaneDown";
      "alt-shift-k" = "vim::ResizePaneUp";
      "alt-shift-l" = "vim::ResizePaneRight";
    };
  }
]
