{
  inputs,
  lib,
  modulesPath,
  pkgs,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./hardware-configuration.nix
    inputs.disko.nixosModules.disko
  ]
  ++ (builtins.attrValues (import ../../modules/nixos/anywhere));

  environment.systemPackages = map lib.lowPrio [ ];

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      # PasswordAuthentication = false;
      # PermitRootLogin = "no";
      # UsePAM = false;
      # KbdInteractiveAuthentication = false;
    };
  };

  user.enable = true;
  user.username = "koen";
  user.extraGroups = [
    "wheel"
    "docker"
  ];
  user.shell = pkgs.bash;

  system.stateVersion = "25.05";
}
