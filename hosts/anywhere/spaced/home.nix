{ outputs, ... }:

{
  imports = [
    outputs.homeManagerModules.zsh
    outputs.homeManagerModules.btop
  ];
}
