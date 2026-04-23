{
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/remote/default.nix
    ../../modules/nixos/tailscale.nix
    ../../modules/nixos/user.nix
  ];

  # Resolves color inversion issue
  boot.kernelPackages = pkgs.linuxPackages_6_1;
  # Allocate enough memory for multiple screens
  boot.kernelParams = [ "cma=256M" ];
  # Use the extlinux boot loader. (NixOS wants to enable GRUB by default)
  boot.loader.grub.enable = false;
  # Enables the generation of /boot/extlinux/extlinux.conf
  boot.loader.generic-extlinux-compatible.enable = true;

  # Packages for remote desktop connection
  environment.systemPackages = with pkgs; [
    deskflow
    freerdp # RDP protocol plugin for Remmina
    keepassxc
    libraspberrypi
    onboard
    raspberrypi-eeprom
    remmina # GUI remote desktop client
  ];

  environment.gnome.excludePackages = with pkgs; [
    # epiphany # web browser
    evince # document viewer
    geary # email reader
    gnome-characters
    gnome-music
    gnome-photos
    gnome-terminal
    gnome-tour
    # video player
  ];

  environment.sessionVariables = {
    # Forces GTK4 apps to use the stable OpenGL renderer
    GSK_RENDERER = "gl";
  };

  hardware.graphics.enable = true;
  hardware.raspberry-pi."4" = {
    fkms-3d.enable = false; # Configured kms in the firmware
    touch-ft5406.enable = false; # Configured in the firmware
  };

  networking.hostName = "pi";
  networking.networkmanager.enable = true;

  # Graphical environment for the thin client
  # (Avoiding the existing gnome.nix module because it forces the nvidia driver)
  services.displayManager.lightdm.enable = true;
  services.desktopManager.gnome = {
    enable = true;
    extraGSettingsOverrides = ''
      [org.gnome.desktop.screensaver]
      lock-enabled=false

      [org.gnome.settings-daemon.plugins.power]
      sleep-inactive-ac-timeout=0
      sleep-inactive-battery-timeout=0
    '';
  };

  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      UsePAM = false;
      KbdInteractiveAuthentication = false;
    };
  };

  system.stateVersion = "25.11";

  user.enable = true;
  user.username = "koen";
  user.extraGroups = [
    "wheel"
    "networkmanager"
  ];
  user.shell = pkgs.bash;
  users.users.${config.user.username}.initialPassword = "pi";
}
