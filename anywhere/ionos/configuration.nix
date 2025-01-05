{ inputs, modulesPath, lib, pkgs, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./hardware-configuration.nix
    inputs.disko.nixosModules.disko
  ] ++ (builtins.attrValues (import ../../modules/nixos/anywhere));

  user.enable = true;
  user.username = "spaced";
  user.extraGroups = ["wheel"];
  user.extraKeys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBySfzAUZItpRMBBunklmpCpRkXx9qfrjNcnEPtvEygB"];
  user.shell = pkgs.bash;

  system.stateVersion = "24.11";
}
