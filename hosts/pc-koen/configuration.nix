{ config, inputs, outputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
  ] ++ (builtins.attrValues outputs.nixosModules);

  home-manager.users.${config.user.username} =
    import ../../hosts/${config.networking.hostName}/home.nix;

  home-manager = {
      backupFileExtension = "backup";
  };

  networking.hostName = "pc-koen";
  networking.networkmanager.enable = true;

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
  };

  nixpkgs.config.allowUnfree = true;

  programs.steam.enable = true;

  system.stateVersion = "24.05";

  time.timeZone = "Europe/Amsterdam";
  # Don't forget to set a password with ‘passwd’.
  user.enable = true;
  user.username = "koen";
}
