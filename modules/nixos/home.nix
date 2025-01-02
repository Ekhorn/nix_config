{ config, ... }:

{
  home-manager.users.${config.user.username} =
    import ../../hosts/${config.networking.hostName}/home.nix;
}
