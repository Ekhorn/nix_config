{ lib, pkgs, ... }:

{
  imports = [
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
  ];
  #programs.hyprland.enable = true;
  #programs.hyprland.xwayland.enable = true;

  xdg.portal = with pkgs; {
    enable = true;
    extraPortals = [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
    xdgOpenUsePortal = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;

    systemd = {
      enable = true;
      variables = ["--all"];
    };

    xwayland.enable = true;
    settings = {
      monitor= ",highrr,auto,1";

      exec-once = [
        "hyprctl setcursor Adwaita 24"
        "[workspace 1 silent] alacritty"
        "[workspace 2 silent] firefox"
      ];

      cursor = {
        no_hardware_cursors = true;
        enable_hyprcursor = true;
      };

      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;

        # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        # Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false;

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false;

        layout = "dwindle";
      };

      # https://wiki.hyprland.org/Configuring/Variables/#decoration
      decoration = {
        rounding = 10;

        # Change transparency of focused and unfocused windows
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        #drop_shadow = true;
        #shadow_range = 4;
        #shadow_render_power = 3;
        #col.shadow = "rgba(1a1a1aee)";

        # https://wiki.hyprland.org/Configuring/Variables/#blur
        blur = {
          enabled = true;
          size = 3;
          passes = 1;

          vibrancy = 0.1696;
        };
      };

      # https://wiki.hyprland.org/Configuring/Variables/#animations
      animations = {
        enabled = true;

        # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
      dwindle = {
        pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mod + P in the keybinds section below
        preserve_split = true; # You probably want this
      };

      # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
      master = {
        new_status = "master";
      };

      misc = {
        disable_hyprland_logo = true;
        force_default_wallpaper = 0;
      };

      input = {
        kb_layout = "us";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";

        follow_mouse = 1;
        accel_profile = "flat";
        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.

        touchpad = {
          natural_scroll = true;
        };
      };

      # https://wiki.hyprland.org/Configuring/Variables/#gestures
      gestures = {
        workspace_swipe = false;
      };

      "$mod" = "SUPER";

      bind = let
        alacritty = lib.getExe pkgs.alacritty;
        nautilus = lib.getExe pkgs.nautilus;
        workspaces = ["1" "2" "3" "4"];
      in [
        "$mod, T, exec, ${alacritty}"
        "$mod, F, exec, fullscreen"
        "$mod, E, exec, ${nautilus}"
        "ALT, F4, killactive,"
        "$mod, Q, killactive,"
        "$mod, L, exit,"
        "$mod, V, togglefloating,"
        "$mod, P, pseudo," # dwindle
        "$mod, Y, togglesplit," # dwindle
        "CONTROL_SUPER_ALT, S, exec, hyprlock & systemctl suspend"
        "CONTROL_SUPER_ALT, P, exec, systemctl poweroff"
        "CONTROL_SUPER_ALT, R, exec, systemctl reboot"
        "SHIFT_SUPER, M, exec, hyprctl keyword monitor , preferred, auto, 1, mirror, eDP-1"
        "SHIFT_SUPER, J, exec, hyprctl keyword monitor , preferred, auto, 1"
        ", PRINT, exec, hyprshot -m region -o ~/Pictures/Screenshots"

        # Move focus with mainMod + arrow keys
        "$mod, H, movefocus, l"
        "$mod, J, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, L, movefocus, d"

        # Example special workspace (scratchpad)
        "$mod, S, togglespecialworkspace, magic"
        "$mod SHIFT, S, movetoworkspace, special:magic"

        # Scroll through existing workspaces with mainMod + scroll
        "$mod, mouse_down, workspace, e-1"
        "$mod, mouse_up, workspace, e+1"
      ]
      # Switch workspaces with mod + [0-9]
      ++ (map (n: "$mod, ${n},workspace, ${n}") workspaces)
      # Move active window to a workspace with mod + SHIFT + [0-9]
      ++ (map (n: "$mod SHIFT, ${n},movetoworkspace, ${n}") workspaces);

      bindr = [
        "SUPER, SUPER_L, exec, rofi -show combi"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bindel = [
        # Laptop multimedia keys for volume and LCD brightness
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, tee /sys/class/backlight/intel_backlight/brightness <<< 24000"
        ",XF86MonBrightnessDown, exec, tee /sys/class/backlight/intel_backlight/brightness <<< 300"
      ];

      windowrulev2 = "suppressevent maximize, class:.*"; # You'll probably like this.
    };
  };
}
