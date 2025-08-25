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

  security.sudo.wheelNeedsPassword = true;
  security.pam.sshAgentAuth.enable = true;

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      UsePAM = false;
      KbdInteractiveAuthentication = false;
    };
  };

  users.users = {
    root.openssh.authorizedKeys.keys =
      config.users.users."${config.user.username}".openssh.authorizedKeys.keys;
  };
}
