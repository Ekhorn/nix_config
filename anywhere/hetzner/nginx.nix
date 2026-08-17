{
  config,
  domain,
  headscale,
  nextcloud,
  ...
}:

{
  security.acme = {
    acceptTerms = true;
    defaults.email = "${config.user.username}@${domain}";
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts = {
      "${headscale.domain}" = {
        enableACME = true;
        forceSSL = true;

        listen = [
          {
            addr = "0.0.0.0";
            port = 80;
            ssl = false;
          }
          {
            addr = headscale.address;
            port = 443;
            ssl = true;
          }
        ];

        locations."/" = {
          proxyPass = "http://${headscale.address}:${headscale.port}";
          proxyWebsockets = true;
        };

        extraConfig = ''
          add_header Strict-Transport-Security "max-age=15552000" always;
        '';
      };

      # Merged with: https://github.com/NixOS/nixpkgs/blob/0dd31db7e6dbf9ce05697c4545f6fe01accec994/nixos/modules/services/web-apps/nextcloud.nix#L1639
      "${nextcloud.domain}" = {
        enableACME = true;
        forceSSL = true;

        listen = [
          {
            addr = "0.0.0.0";
            port = 80;
            ssl = false;
          }
          {
            addr = "100.64.0.5";
            port = 443;
            ssl = true;
          }
        ];
      };
    };
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
