{
  config,
  inputs,
  lib,
  outputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
  ]
  ++ (builtins.attrValues outputs.nixosModules);

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  hardware.bluetooth.powerOnBoot = false;

  home-manager = {
    backupFileExtension = "backup";
    users.${config.user.username} = import ../../hosts/${config.networking.hostName}/home.nix;
  };

  networking.hostName = "laptop-koen";
  networking.networkmanager.enable = true;

  system.stateVersion = "25.05";

  systemd.services.fprintd = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "simple";
  };
  services.fprintd.enable = true;
  services.xserver.videoDrivers = lib.mkForce [ ];

  time.timeZone = "Europe/Amsterdam";
  # Don't forget to set a password with ‘passwd’.
  user.enable = true;
  user.username = "koen";
}
