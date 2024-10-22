{ pkgs, ... }:

{
  environment.variables.JDK_PATH = "${pkgs.jdk11}/";
  environment.variables.NODEJS_PATH = "${pkgs.nodePackages_latest.nodejs}/";
  environment.variables.XDG_CURRENT_DESKTOP = "Hyprland";
  environment.variables.XDG_SESSION_TYPE = "wayland";
  environment.variables.XDG_SESSION_DESKTOP = "Hyprland";
}
