{ lib, outputs, pkgs, ... }:

{
  imports = [] ++ (builtins.attrValues outputs.homeManagerModules);

  home.username = "koen";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    slack
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];



  home.file = {
    ".unison/default.prf".text = ''
      root=/home/koen/Desktop/
      root=ssh://koen@pc-koen//home/koen/Desktop/

      ignore = Name ?*
      ignorenot = Name koen.kdbx
    '';
  };

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "discord"
      "obsidian"
      "slack"
      "vscode"
    ];

  programs.home-manager.enable = true;
}
