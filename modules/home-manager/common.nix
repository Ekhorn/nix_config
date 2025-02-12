{ config, lib, pkgs, ... }:

{
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
    jdk17
    jetbrains.idea-community
    jq
    kubectl
    lld
    lsof
    gnumake
    nautilus
    neovim
    nixos-anywhere
    nodejs_20
    obsidian
    obs-studio
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
    x11_ssh_askpass
    yarn-berry
  ];

  home.homeDirectory = "/home/${config.home.username}";

  programs.java.enable = true;
  programs.java.package = pkgs.jdk17;
}
