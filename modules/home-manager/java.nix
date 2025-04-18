{ pkgs, ... }:

{
  programs.java.enable = true;
  programs.java.package = pkgs.jdk21_headless;
  home.packages = with pkgs; [
    gradle_8
  ];
}
