{ pkgs, ... }:

{
  environment.variables.XDG_CURRENT_DESKTOP = "Hyprland";
  environment.variables.XDG_SESSION_DESKTOP = "Hyprland";
  xdg.icons.enable = true;
}
