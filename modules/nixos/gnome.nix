{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
    videoDrivers = [ "nvidia" ];
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  environment.gnome.excludePackages = with pkgs; [
    epiphany # web browser
    evince # document viewer
    geary # email reader
    # gnome-characters
    gnome-music
    # gnome-photos
    gnome-terminal
    gnome-tour
    totem # video player
  ];
}
