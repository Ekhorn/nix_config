{ config, ... }:

{
  boot.loader.grub = {
    # no need to set devices, disko will add all devices that have a EF02 partition to the list already
    # devices = [ ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  nix.settings.trusted-users = [
    "root"
    "@wheel"
  ];

  programs.zsh.enable = true;

  security.sudo.wheelNeedsPassword = true;
  security.pam.sshAgentAuth.enable = true;

  users.users = {
    root.openssh.authorizedKeys.keys =
      config.users.users."${config.user.username}".openssh.authorizedKeys.keys;
  };
}
