{ headscale, ... }:

{
  services.headscale = {
    enable = true;
    address = headscale.address;
    port = headscale.port;

    settings = {
      server_url = "https://${headscale.domain}";

      dns = {
        base_domain = headscale.baseDomain;
        override_local_dns = false;
      };

      log.level = "debug";
    };
  };
}
