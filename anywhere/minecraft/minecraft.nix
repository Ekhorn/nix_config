{ pkgs, ... }:

{
  services.minecraft-server = {
    enable = true;
    eula = true;
    package = pkgs.minecraftServers.vanilla-1-21;
    declarative = true;
    whitelist = {
      # This is a mapping from Minecraft usernames to UUIDs. You can use https://mcuuid.net/ to get a Minecraft UUID for a username
      ekhorn = "e96bbc5a-025e-44de-81a8-95ede4090713";
    };
    serverProperties = {
      server-port = 43000;
      difficulty = 3;
      gamemode = "survival";
      max-players = 5;
      motd = "NixOS Minecraft server!";
      white-list = true;
      allow-cheats = false;
      view-distance = 12;
    };
    jvmOpts = "-Xms2048M -Xmx4096M";
  };
}
