{ ... }:

{
  virtualisation = {
    # Docker root
    #docker.enable = true;
    # Docker rootless
    docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };
    podman = {
      enable = true;
      # docker alias to podman 
      #dockerCompat = true;
      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };
}
