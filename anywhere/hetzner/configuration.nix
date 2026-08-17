{
  config,
  inputs,
  lib,
  modulesPath,
  pkgs,
  ...
}:

let
  domain = "kschellingerhout.nl";

  headscale = {
    domain = "headscale.${domain}";
    address = "127.0.0.1";
    port = 8080;
    baseDomain = "tailnet.${domain}";
  };

  nextcloud = {
    domain = "nextcloud.${headscale.baseDomain}";
  };
in
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./hardware-configuration.nix
    ./headscale.nix
    ./nextcloud.nix
    ./nginx.nix
    ./tailscale.nix
    inputs.disko.nixosModules.disko
    inputs.home-manager.nixosModules.home-manager
  ]
  ++ (builtins.attrValues (import ../../modules/nixos/anywhere));

  environment.systemPackages = map lib.lowPrio [ ];

  home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${config.user.username} = import ./home.nix;
  };

  services.openssh = {
    enable = true;
    ports = [ 57313 ];
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      UsePAM = false;
      KbdInteractiveAuthentication = false;
    };
  };

  system.stateVersion = "25.05";

  user.enable = true;
  user.username = "koen";
  user.extraGroups = [
    "wheel"
    "headscale"
  ];
  user.shell = pkgs.zsh;

  _module.args = {
    inherit domain headscale nextcloud;
  };
}
