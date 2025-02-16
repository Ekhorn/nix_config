{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.emu = {
    # imports = [ ./hyprland.nix ];

    home.stateVersion = "24.11";

    home.packages = with pkgs; [
      adwaita-icon-theme
      chromium
      firefox
      # hyprcursor
      # hyprpicker
      # hyprshot
    ];

    programs.home-manager.enable = true;
  };
}
