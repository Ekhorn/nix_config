{ pkgs, config, ... }:

let
  domain = "kschellingerhout.nl";
in
{
  services.nextcloud = {
    enable = true;
    configureRedis = true;
    package = pkgs.nextcloud31;
    hostName = "localhost";
    database.createLocally = true;
    https = false;
    extraAppsEnable = true;
    extraApps = with config.services.nextcloud.package.packages.apps; {
      # https://github.com/NixOS/nixpkgs/blob/master/pkgs/servers/nextcloud/packages/nextcloud-apps.json
      inherit
        calendar
        ;

      # xxx = pkgs.fetchNextcloudApp rec {
      #   url = ".tar.gz";
      #   sha256 = "";
      # };
    };

    config = {
      adminpassFile = "/etc/nextcloud-admin-pass";
      dbtype = "sqlite";
    };
    settings = {
      trusted_domains = [ "nextcloud.tailnet.${domain}" ];
    };
  };
  services.nginx.virtualHosts."localhost".listen = [
    {
      addr = "100.64.0.5";
      port = 8080;
    }
  ];

  # Ensure systemd service is enabled
  systemd.services.phpfpm-nextcloud.wantedBy = [ "multi-user.target" ];
}
