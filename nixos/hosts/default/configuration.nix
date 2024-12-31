{ config, inputs, ... }:

let
  modules = ../../modules;
in
{
  imports = [
    "${modules}/common.nix"
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    # The following modules MUST be specific, and NOT general like "security" or
    # "services", only "common" is allowed.
    "${modules}/greetd.nix"
    "${modules}/hyprland.nix"
    "${modules}/nvidia.nix"
    "${modules}/rust.nix"
    "${modules}/ssh.nix"
    "${modules}/user.nix"
    "${modules}/virtualization.nix"
    "${modules}/wayland.nix"
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "${config.user.username}" = import ./home.nix;
    };
  };

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
    flags = [ "--update-input" "stable" "unstable" "rust-overlay" ];
  };
  system.stateVersion = "24.05";

  time.timeZone = "Europe/Amsterdam";

  # Don't forget to set a password with ‘passwd’.
  user.enable = true;
  user.username = "koen";
}
