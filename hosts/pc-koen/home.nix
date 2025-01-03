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
  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    adwaita-icon-theme
    awscli2
    celluloid
    chromium
    clang
    cmake
    deno
    dig
    discord
    dunst
    eog
    fastfetch
    fd
    firefox
    #(flameshot.override { enableWlrSupport = true; })
    #gcc
    gedit
    glxinfo
    graphviz
    gradle_7
    helm
    htop
    hyprcursor
    hyprpicker
    hyprshot
    #input-leap
    #jdk17
    jq
    #kitty
    kubectl
    lld
    lsof
    gnumake
    nautilus
    neovim
    nixos-anywhere
    nodejs_20
    obsidian
    pciutils
    pinentry
    podman-compose
    postgresql_17
    protobuf
    python3
    ripgrep
    seahorse
    spice-vdagent
    sqlite
    thunderbird
    tree-sitter
    unison
    unzip
    wget
    yarn-berry
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    ".unison/default.prf".text = ''
      root=/home/koen/Desktop/
      root=ssh://koen@laptop-koen//home/koen/Desktop/

      ignore = Name ?*
      ignorenot = Name koen.kdbx
    '';
  };

  home.sessionVariables = {
  };

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "discord"
      "obsidian"
      "vscode"
    ];

  programs.home-manager.enable = true;
}
