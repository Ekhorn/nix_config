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

  home-manager.users.${config.user.username} =
    import ../../hosts/${config.networking.hostName}/home.nix;

  home-manager = {
    backupFileExtension = "backup";
  };

  networking.hostName = "laptop-koen";
  networking.networkmanager.enable = true;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "nvidia-x11"
      "nvidia-settings"
    ];

  system.stateVersion = "24.05";

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
