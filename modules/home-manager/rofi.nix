{ pkgs, ... }:

{
  home.packages = with pkgs; [
    rofi-bluetooth
  ];
  programs.rofi = {
    enable = true;
    extraConfig = {
      modi = "recursivebrowser,calc,top,ssh";
      combi-modes = "window,drun";
    };
    package = pkgs.rofi-wayland;
    plugins = with pkgs; [
      (rofi-calc.override { rofi-unwrapped = rofi-wayland-unwrapped; })
      (rofi-top.override { rofi-unwrapped = rofi-wayland-unwrapped; })
    ];
  };
}
