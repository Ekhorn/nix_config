{ pkgs, ... }:

{
  environment.variables.XDG_CURRENT_DESKTOP = "Hyprland";
  environment.variables.XDG_SESSION_DESKTOP = "Hyprland";

  programs.hyprland.enable = true;
  #programs.hyprland.xwayland.enable = true;

  xdg.icons.enable = true;
  xdg.portal = {
    enable = true;
    #wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
    xdgOpenUsePortal = true;
  };

  #wayland.windowManager.hyprland = {
  #  enable = true;
  #
  #  settings = {
  #    monitor= ",highrr,auto,1";
  #
  #    cursor = {
  #      no_hardware_cursors = true;
  #      enable_hyprcursor = true;
  #    };
  #
  #    general = {
  #      gaps_in = 5;
  #      gaps_out = 20;
  #      border_size = 2;
  #      col.active_border = "rgba(33ccffee) rgba(00ff99ee) 45deg";
  #      col.inactive_border = "rgba(595959aa)";
  #      resize_on_border = false;
  #      allow_tearing = false;
  #      layout = dwindle;
  #    };
  #  };
  #};
}
