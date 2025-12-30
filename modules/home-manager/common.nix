{
  config,
  outputs,
  pkgs,
  ...
}:

{
  imports = [
    ../shared/unfree.nix
  ];

  home.packages = with pkgs; [
    adwaita-icon-theme
    awscli2
    latest.chromium
    clang
    cmake
    dconf2nix
    unstable.deno
    deskflow
    dig
    latest.discord
    dunst
    fastfetch
    fd
    file-roller
    latest.firefox
    #(flameshot.override { enableWlrSupport = true; })
    #gcc
    mesa-demos
    go
    graphviz
    kubernetes-helm
    htop
    #input-leap
    jdk21_headless
    jetbrains.idea
    jq
    kubectl
    libreoffice
    lld
    lsof
    gnumake
    nautilus
    neovim
    nil
    nixfmt-rfc-style
    package-version-server
    nixos-anywhere
    nodejs_24
    obsidian
    obs-studio
    openssl
    pastel
    pciutils
    pinentry-gnome3
    playerctl
    podman-compose
    postgresql_17
    protobuf
    python3
    ripgrep
    seahorse
    spice-vdagent
    sqlite
    latest.thunderbird
    tree-sitter
    unison
    unzip
    unstable.vulnix
    wget
    x11_ssh_askpass
    yarn-berry
    zip
  ];

  home.homeDirectory = "/home/${config.home.username}";

  nixpkgs.overlays = outputs.overlays;

  unfree.enable = true;
  unfree.packages = [
    "discord"
    "idea"
    "obsidian"
    "vscode"
  ];
}
