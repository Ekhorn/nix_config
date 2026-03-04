{ config, ... }:

{
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
