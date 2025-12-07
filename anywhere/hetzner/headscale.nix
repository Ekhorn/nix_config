{ ... }:

let
  domain = "kschellingerhout.nl";
in
{
  services.headscale = {
    enable = true;
    port = 443;
    address = "0.0.0.0";
    user = "koen";
    settings = {
      server_url = "https://headscale.${domain}:443";
      tls_letsencrypt_hostname = "headscale.${domain}";
      dns = {
        base_domain = "tailnet.${domain}";
        override_local_dns = false;
      };
      log.level = "debug";
    };
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      80
      443
    ];
  };
}
