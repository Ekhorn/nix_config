{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    plugins = with pkgs; [
      rofi-bluetooth
      rofi-wayland
      rofi-calc
    ];
  };
}
