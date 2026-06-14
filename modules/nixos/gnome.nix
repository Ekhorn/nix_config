{ pkgs, ... }:

{
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;
  # Gets enabled when flatpak is enabled
  services.gnome.gnome-software.enable = false;
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  environment.gnome.excludePackages = with pkgs; [
    # epiphany # web browser
    # gnome-characters
    gnome-console
    gnome-contacts
    gnome-connections
    gnome-maps
    gnome-music
    gnome-logs
    gnome-terminal
    gnome-tour
    papers # document viewer
    yelp # help
  ];
}
