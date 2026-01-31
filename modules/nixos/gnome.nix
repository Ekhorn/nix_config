{ pkgs, ... }:

{
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;
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
    evince # document viewer
    geary # email reader
    # gnome-characters
    gnome-music
    # gnome-photos
    gnome-terminal
    gnome-tour
    # video player
  ];
}
