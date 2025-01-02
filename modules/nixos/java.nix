{ pkgs, ... }:

{
  #environment.variables.JDK_PATH = "${pkgs.jdk17}/";
  programs.java = {
    enable = true;
    package = pkgs.jdk17;
  };
}
