{ pkgs, ... }:

{
  programs.gnome-shell = {
    enable = true;
    extensions = with pkgs.gnomeExtensions; [
      { package = system-monitor; }
      { package = status-icons; }
      # { package = places-menu; }
      { package = auto-move-windows; }
    ];
  };
}
