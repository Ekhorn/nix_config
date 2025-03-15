{
  config,
  inputs,
  pkgs,
  ...
}:

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
    go
    graphviz
    gradle_8
    helm
    htop
    hyprcursor
    hyprpicker
    hyprshot
    #input-leap
    jdk21_headless
    jetbrains.idea-community
    jq
    kubectl
    lld
    lsof
    gnumake
    nautilus
    neovim
    nil
    nixfmt-rfc-style
    unstable.package-version-server
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
    vulnix
    wget
    x11_ssh_askpass
    yarn-berry
  ];

  home.homeDirectory = "/home/${config.home.username}";

  nixpkgs.overlays = [
    (final: prev: {
      unstable = import inputs.unstable {
        system = prev.system;
      };
    })
  ];
}
