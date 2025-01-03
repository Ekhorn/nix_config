{ config, inputs, outputs, pkgs, ... }:

{
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;

  environment.systemPackages = with pkgs; [
    alacritty
    bluez
    gnome-keyring
    gnupg
    greetd.tuigreet
    wl-clipboard
  ];
  environment.variables.NODEJS_PATH = "${pkgs.nodePackages_latest.nodejs}/";

  home-manager.extraSpecialArgs = { inherit inputs outputs; };

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

  system.autoUpgrade = {
    enable = true;
    flake = "/etc/nixos#${config.networking.hostName}";
    flags = [ "--update-input" "stable" "unstable" "home-manager" "rust-overlay" ];
  };
}
