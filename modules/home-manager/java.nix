{ pkgs, ... }:

{
  programs.java.enable = true;
  programs.java.package = pkgs.jdk21_headless;
}
