{ outputs, ... }:

{
  imports = [
    outputs.homeManagerModules.zsh
    outputs.homeManagerModules.btop
  ];

  home.stateVersion = "26.05";
}
