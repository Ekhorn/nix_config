{ pkgs, ... }:

{
  home.packages = with pkgs; [
    vscode-extensions.jnoortheen.nix-ide
    vscode-extensions.rust-lang.rust-analyzer
    vscode-extensions.streetsidesoftware.code-spell-checker
  ];

  programs.vscode = {
    enable = true;
    extensions = with pkgs; [
      vscode-extensions.jnoortheen.nix-ide
      vscode-extensions.rust-lang.rust-analyzer
      vscode-extensions.streetsidesoftware.code-spell-checker
    ];
    userSettings = builtins.fromJSON (builtins.readFile ./settings.json);
  };
}
