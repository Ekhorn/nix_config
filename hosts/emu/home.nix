{ pkgs, ... }:

{
  imports = [ ];

  # imports = [ ./hyprland.nix ];

  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    adwaita-icon-theme
    firefox
    # hyprcursor
    # hyprpicker
    # hyprshot
  ];

  programs.home-manager.enable = true;
}
