{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    font-awesome
    noto-fonts
    ubuntu_font_family
  ];
}
