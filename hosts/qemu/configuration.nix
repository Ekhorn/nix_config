{ config, lib, pkgs, ... }:

let
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
  hyprland-session = "${pkgs.hyprland}/share/wayland-sessions";
in
{
  imports = [
    ./hardware-configuration.nix
    ./home.nix
  ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;

  #environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.GDK_BACKEND = "wayland";
  environment.sessionVariables.MOZ_ENABLE_WAYLAND = "1";
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
  environment.sessionVariables.T_QPA_PLATFORM = "wayland";

  environment.systemPackages = with pkgs; [
    alacritty
    greetd.tuigreet
    nautilus
  ];

  environment.variables.XDG_SESSION_TYPE = "wayland";
  environment.variables.XDG_CURRENT_DESKTOP = "Hyprland";
  environment.variables.XDG_SESSION_DESKTOP = "Hyprland";

  networking.hostName = "nixos";

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
  };

  nixpkgs.config.allowUnfree = true;

  programs.dconf.enable = true;
  programs.firefox.enable = true;

  security.polkit.enable = true;
  security.rtkit.enable = true;

  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     default_session = {
  #       command = "${tuigreet} --time --time-format '%H:%M | %a * %h | %F' --remember --remember-session --sessions ${hyprland-session}";
  #       user = "emu";
  #     };
  #   };
  # };
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true; # enable copy and paste between host and guest
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
    videoDrivers = [];
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  system.stateVersion = "24.11";

  time.timeZone = "Europe/Amsterdam";

  users.users.emu = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      git
    ];
  };

  xdg.icons.enable = true;
}
