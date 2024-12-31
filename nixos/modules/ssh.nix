{ config, lib, pkgs, ... }:

{
  environment.variables.SSH_ASKPASS = lib.mkForce "${pkgs.x11_ssh_askpass}/libexec/x11-ssh-askpass";

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      AllowUsers = [ config.user.username ];
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      UseDns = true;
    };
  };
}
