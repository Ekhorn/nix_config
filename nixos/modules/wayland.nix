{ ... }:

{
  #environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.GDK_BACKEND = "wayland";
  environment.sessionVariables.MOZ_ENABLE_WAYLAND = "1";
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
  environment.sessionVariables.T_QPA_PLATFORM = "wayland";
  environment.variables.XDG_SESSION_TYPE = "wayland";
}
