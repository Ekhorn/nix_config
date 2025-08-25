{
  inputs,
  modulesPath,
  lib,
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

  # do not use DHCP, as DigitalOcean provisions IPs using cloud-init
  networking.useDHCP = lib.mkForce false;

  services.cloud-init = {
    enable = true;
    network.enable = true;
  };
  system.stateVersion = "24.11";

  user.enable = true;
  user.username = "spaced";
  user.extraGroups = [
    "wheel"
    "docker"
  ];
  user.extraKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOpnh3ftRObnt6vht3N6qcJbpzHzzXi/5eE0gr7aT5G4"
  ];
  user.shell = pkgs.bash;

  virtualisation.docker.enable = true;
}
