{ ... }:

{
  virtualisation = {
    docker.enable = true;
    docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };
    podman = {
      enable = true;
      #dockerCompat = true;
      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # The rootless docker user unit is installed globally (/etc/systemd/user/),
  # so it also runs in the GDM greeter's user manager, which has no subuid
  # ranges and can never start rootlesskit. Exclude it explicitly (nixpkgs
  # already excludes root); without this, docker fails ~5x at every boot under
  # gdm-greeter and hits its start limit.
  systemd.user.services.docker.unitConfig.ConditionUser = [
    "!root"
    "!gdm-greeter"
  ];
}
