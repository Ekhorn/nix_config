{ outputs, ... }:

{
  imports = [ ./hardware-configuration.nix ]
    ++ (builtins.attrValues outputs.nixosModules);

  networking.hostName = "pc-koen";
  networking.networkmanager.enable = true;

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
  };

  nixpkgs.config.allowUnfree = true;

  programs.steam.enable = true;

  system.autoUpgrade = {
    enable = true;
    flake = "/etc/nixos#default";
    flags = [ "--update-input" "stable" "unstable" "home-manager" "rust-overlay" ];
  };
  system.stateVersion = "24.05";

  time.timeZone = "Europe/Amsterdam";

  # Don't forget to set a password with ‘passwd’.
  user.enable = true;
  user.username = "koen";
}
