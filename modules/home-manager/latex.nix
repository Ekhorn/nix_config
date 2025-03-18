{ pkgs, ... }:

{
  home.packages = with pkgs; [
    texlab
    texliveMedium
    biber
    texlivePackages.hyperref
    texlivePackages.a4wide
    texlivePackages.fancyhdr
    texlivePackages.graphbox
    zathura
  ];
}
