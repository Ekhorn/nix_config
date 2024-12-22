{ pkgs, lib, config, ... }:

{
  boot.blacklistedKernelModules = ["nouveau"];
  boot.extraModprobeConfig = ''
    blacklist nouveau
    options nouveau modeset=0
  '';
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;

  #environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.GDK_BACKEND = "wayland";
  environment.sessionVariables.MOZ_ENABLE_WAYLAND = "1";
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
  environment.sessionVariables.T_QPA_PLATFORM = "wayland";
  environment.systemPackages = with pkgs; [
    (rust-bin.fromRustupToolchainFile ./rust-toolchain.toml)
    cargo-watch
    cargo-udeps
    cargo-tauri
    sqlx-cli
  ];
  #environment.variables.JDK_PATH = "${pkgs.jdk17}/";
  environment.variables.NODEJS_PATH = "${pkgs.nodePackages_latest.nodejs}/";
  environment.variables.XDG_CURRENT_DESKTOP = "Hyprland";
  environment.variables.XDG_SESSION_TYPE = "wayland";
  environment.variables.XDG_SESSION_DESKTOP = "Hyprland";
  environment.variables.SSH_ASKPASS = lib.mkForce "${pkgs.x11_ssh_askpass}/libexec/x11-ssh-askpass";

  fonts.packages = with pkgs; [
    font-awesome
    noto-fonts
    ubuntu_font_family
  ];

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;
  hardware.graphics.enable = true;
  #hardware.graphics.enable32Bit = true;
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };

  imports = [
    ./greetd.nix
    ./hardware-configuration.nix
    ./packages.nix
  ];

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

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    (import (builtins.fetchTarball "https://github.com/oxalica/rust-overlay/archive/master.tar.gz"))
  ];

  programs.dconf.enable = true;
  programs.direnv.enable = true;
  programs.gnupg = {
    agent.enable = true;
    agent.pinentryPackage = pkgs.pinentry-gnome3;
  };
  programs.hyprland.enable = true;
  #programs.hyprland.xwayland.enable = true;
  programs.java = {
    enable = true;
    package = pkgs.jdk17;
  };
  programs.zsh.enable = true;

  security.pam.services.greetd.enableGnomeKeyring = true;
  security.polkit.enable = true;
  security.rtkit.enable = true;

  services.gnome.gnome-keyring.enable = true;
  services.gvfs.enable = true;
  services.logind.extraConfig = ''
    HandlePowerKey=ignore
  '';
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      AllowUsers = ["koen"];
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      UseDns = true;
    };
  };
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
    user = "koen";
    configDir = "/home/koen/.local/state/syncthing";
  };
  # Allow non-root access to update screen backlight brightness
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"
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

  system.autoUpgrade.channel = "https://channels.nixos.org/nixos-24.11";
  system.stateVersion = "24.05";

  time.timeZone = "Europe/Amsterdam";

  # Don't forget to set a password with ‘passwd’.
  users.users.koen = {
    extraGroups = [ "networkmanager" "wheel" ];
    isNormalUser = true;
    packages = with pkgs; [
      adwaita-icon-theme
    ];
    shell = pkgs.zsh;
  };

  virtualisation = {
    #docker.enable = true;
    docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };
    podman = {
      enable = true;
      #dockerCompat = true;
      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  xdg.icons.enable = true;
  xdg.portal = {
    enable = true;
    #wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
    xdgOpenUsePortal = true;
  };
}
