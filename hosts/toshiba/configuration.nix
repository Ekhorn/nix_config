{
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/tailscale.nix
    ../../modules/nixos/user.nix
  ];

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
  };

  # Packages for remote desktop connection
  environment.systemPackages = with pkgs; [
    freerdp # RDP protocol plugin for Remmina
    keepassxc
    remmina # GUI remote desktop client
  ];

  environment.gnome.excludePackages = with pkgs; [
    # epiphany # web browser
    evince # document viewer
    geary # email reader
    gnome-characters
    gnome-connections
    gnome-music
    gnome-photos
    gnome-terminal
    gnome-tour
    # video player
  ];

  hardware.graphics.enable = true;

  networking.hostName = "toshiba";
  networking.networkmanager.enable = true;

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

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
}
