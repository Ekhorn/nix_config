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
  ++ (builtins.attrValues (import ../../../modules/nixos/anywhere));

  environment.systemPackages = map lib.lowPrio [ ];

  networking.hostName = "anywhere";

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

  system.stateVersion = "26.05";

  user.enable = true;
  user.username = "koen";
  user.extraGroups = [
    "wheel"
    "docker"
  ];
  user.shell = pkgs.bash;
}
