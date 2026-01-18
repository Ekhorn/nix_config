{ lib, ... }:

{
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      cursor-size = 24;
      cursor-theme = "Adwaita";
      enable-animations = false;
      gtk-enable-primary-paste = false;
    };

    "org/gnome/shell/keybindings" = {
      switch-to-application-1 = [ ];
      switch-to-application-2 = [ ];
      switch-to-application-3 = [ ];
      switch-to-application-4 = [ ];
    };

    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      accel-profile = "flat";
      click-method = "areas";
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>q" ];
      move-to-workspace-1 = [ "<Shift><Super>1" ];
      move-to-workspace-2 = [ "<Shift><Super>2" ];
      move-to-workspace-3 = [ "<Shift><Super>3" ];
      move-to-workspace-4 = [ "<Shift><Super>4" ];
      switch-to-workspace-1 = [ "<Super>1" ];
      switch-to-workspace-2 = [ "<Super>2" ];
      switch-to-workspace-3 = [ "<Super>3" ];
      switch-to-workspace-4 = [ "<Super>4" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>t";
      command = "alacritty";
      name = "alacritty";
    };

    "org/gnome/shell" = {
      disabled-extensions = [
        "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
        "windowsNavigator@gnome-shell-extensions.gcampax.github.com"
        "window-list@gnome-shell-extensions.gcampax.github.com"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com"
        "drive-menu@gnome-shell-extensions.gcampax.github.com"
        "native-window-placement@gnome-shell-extensions.gcampax.github.com"
        "light-style@gnome-shell-extensions.gcampax.github.com"
        "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
        "apps-menu@gnome-shell-extensions.gcampax.github.com"
      ];
      enabled-extensions = [
        "system-monitor@gnome-shell-extensions.gcampax.github.com"
        "status-icons@gnome-shell-extensions.gcampax.github.com"
        "places-menu@gnome-shell-extensions.gcampax.github.com"
        "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
        "tilingshell@ferrarodomenico.com"
      ];
      welcome-dialog-last-shown-version = "47.2";
    };

    "org/gnome/shell/extensions/auto-move-windows" = {
      application-list = [
        "dev.zed.Zed.desktop:1"
        "firefox.desktop:2"
        "obsidian.desktop:3"
      ];
    };

    "org/gnome/shell/extensions/tilingshell" = {
      active-screen-edges = false;
      edge-tiling-offset = 0;
      enable-autotiling = true;
      enable-blur-selected-tilepreview = false;
      enable-blur-snap-assistant = false;
      enable-directional-focus-tiled-only = true;
      enable-screen-edges-windows-suggestions = false;
      enable-snap-assistant-windows-suggestions = false;
      enable-span-multiple-tiles = false;
      enable-tiling-system-windows-suggestions = false;
      focus-window-down = [ "<Alt>j" ];
      focus-window-left = [ "<Alt>h" ];
      focus-window-right = [ "<Alt>l" ];
      focus-window-up = [ "<Alt>k" ];
      inner-gaps = lib.hm.gvariant.mkUint32 0;
      last-version-name-installed = "17.0";
      layouts-json = ''
        [{
          "id":"Default",
          "tiles":[
             {"x":0,"y":0,"width":0.67,"height":1,"groups":[1]},
             {"x":0.67,"y":0,"width":0.33,"height":0.5,"groups":[2,1]},
             {"x":0.67,"y":0.5,"width":0.33,"height":0.5,"groups":[2,1]}
          ]
        }]'';
      outer-gaps = lib.hm.gvariant.mkUint32 0;
      overridden-settings = ''
        {
          "org.gnome.mutter.keybindings": {
            "toggle-tiled-right": "['<Super>Right']",
            "toggle-tiled-left": "['<Super>Left']"
          },
          "org.gnome.desktop.wm.keybindings": {
            "maximize": "['<Super>Up']",
            "unmaximize": "['<Super>Down', '<Alt>F5']"
          }
        }'';
      override-window-menu = false;
      quarter-tiling-threshold = 0;
      selected-layouts = [ [ "Default" ] ];
      show-indicator = true;
      snap-assistant-animation-time = 0;
      snap-assistant-threshold = 0;
      span-multiple-tiles-activation-key = [ "-1" ];
      tile-preview-animation-time = 0;
      tiling-system-activation-key = [ "2" ];
      tiling-system-deactivation-key = [ "-1" ];
    };
  };
}
