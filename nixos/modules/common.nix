{ config, pkgs, ... }:

{
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;

  environment.systemPackages = with pkgs; [
    alacritty
    awscli2
    bluez
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
    gcc
    gedit
    gh
    git
    glxinfo
    gnome-keyring
    gnupg
    graphviz
    gradle_7
    greetd.tuigreet
    helm
    htop
    hyprcursor
    hypridle
    hyprlock
    hyprpaper
    hyprpicker
    hyprshot
    #input-leap
    #jdk17
    jq
    keepassxc
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
    rofi-bluetooth
    rofi-wayland
    seahorse
    spice-vdagent
    sqlite
    thunderbird
    tree-sitter
    unison
    unzip
    vscode
    waybar
    wget
    wl-clipboard
    x11_ssh_askpass
    yarn-berry
  ];
  environment.variables.NODEJS_PATH = "${pkgs.nodePackages_latest.nodejs}/";

  programs.zsh.enable = true;
  programs.dconf.enable = true;
  programs.direnv.enable = true;
  programs.gnupg = {
    agent.enable = true;
    agent.pinentryPackage = pkgs.pinentry-gnome3;
  };

  fonts.packages = with pkgs; [
    font-awesome
    noto-fonts
    ubuntu_font_family
  ];

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;
  hardware.graphics.enable = true;
  #hardware.graphics.enable32Bit = true;

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };

  security.pam.services.greetd.enableGnomeKeyring = true;
  security.polkit.enable = true;
  security.rtkit.enable = true;

  services.gnome.gnome-keyring.enable = true;
  services.gvfs.enable = true;
  services.logind.extraConfig = ''
    HandlePowerKey=ignore
  '';
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  #services.qemuGuest.enable = true;
  #services.spice-vdagentd.enable = true;
  services.syncthing = {
    enable = true;
    user = config.user.username;
    configDir = "/home/${config.user.username}/.local/state/syncthing";
  };
  # Allow non-root access to update screen backlight brightness
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight",
    MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"
  '';
  services.xserver = {
    enable = true;
    #desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
    videoDrivers = ["nvidia"];
    xkb = {
      layout = "us";
      variant = "";
    };
  };
}
