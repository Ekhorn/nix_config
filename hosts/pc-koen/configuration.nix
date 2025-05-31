{
  config,
  inputs,
  outputs,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
  ] ++ (builtins.attrValues outputs.nixosModules);

  hardware.bluetooth.powerOnBoot = true;

  home-manager.users.${config.user.username} =
    import ../../hosts/${config.networking.hostName}/home.nix;

  home-manager = {
    backupFileExtension = "backup";
  };

  networking.hostName = "pc-koen";
  networking.networkmanager.enable = true;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  nixpkgs.config.allowUnfree = true;

  programs.steam.enable = true;

  users.groups.github-runner = { };
  users.users.github-runner = {
    isNormalUser = true;
    group = "github-runner";
    extraGroups = [ "docker" ];
  };
  services.github-runners.spaced.enable = true;
  services.github-runners.spaced.user = "github-runner";
  services.github-runners.spaced.url = "https://github.com/Ekhorn/spaced";
  services.github-runners.spaced.tokenFile = "/etc/gh_token";
  services.github-runners.spaced.ephemeral = false;
  services.github-runners.spaced.workDir = "/data/runner_workspace";
  services.github-runners.spaced.extraPackages = with pkgs; [
    nodejs_20
    config.virtualisation.docker.package
    ccache
    jq
  ];
  services.github-runners.spaced.serviceOverrides = {
    ProtectHome = false;
    ReadWritePaths = [
      "/data/ccache"
      "/data/runner_workspace"
    ];
  };

  system.stateVersion = "25.05";

  time.timeZone = "Europe/Amsterdam";
  # Don't forget to set a password with ‘passwd’.
  user.enable = true;
  user.username = "koen";
  user.extraGroups = [
    "wheel"
    "networkmanager"
    "docker"
  ];
}
