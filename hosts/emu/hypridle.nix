{
  config,
  lib,
  pkgs,
  ...
}:

let
  hyprlock = lib.getExe pkgs.hyprlock;
  loginctl = lib.getExe' pkgs.systemd "loginctl";
  hyprctl = lib.getExe' config.wayland.windowManager.hyprland.package "hyprctl";
in
{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "${hyprctl} dispatch dpms on"; # turn on display after resume.
        before_sleep_cmd = "${loginctl} lock-session"; # lock before suspend.
        lock_cmd = "pidof hyprlock || ${hyprlock}"; # lock screen.
      };
    };
  };
}
