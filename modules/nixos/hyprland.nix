{ pkgs, ... }:

{
  environment.variables.XDG_CURRENT_DESKTOP = "Hyprland";
  environment.variables.XDG_SESSION_DESKTOP = "Hyprland";
  xdg.icons.enable = true;

  # Allow non-root access to update screen backlight brightness
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight",
    MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"
  '';
}
