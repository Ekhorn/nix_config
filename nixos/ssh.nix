{ ... }:

{
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      AllowUsers = ["koen"];
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      UseDns = true;
    };
  };
}
