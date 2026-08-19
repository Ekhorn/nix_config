{
  config,
  nextcloud,
  pkgs,
  ...
}:

{
  services.nextcloud = {
    enable = true;
    configureRedis = true;
    package = pkgs.nextcloud33;

    hostName = nextcloud.domain;
    https = true;

    database.createLocally = true;

    extraAppsEnable = true;
    extraApps = with config.services.nextcloud.package.packages.apps; {
      # https://github.com/NixOS/nixpkgs/blob/master/pkgs/servers/nextcloud/packages/nextcloud-apps.json
      inherit calendar spreed;
    };

    config = {
      adminpassFile = "/etc/nextcloud-admin-pass";
      dbtype = "sqlite";
    };

    settings = {
      trusted_domains = [ nextcloud.domain ];
      overwriteprotocol = "https";
    };
  };
}
