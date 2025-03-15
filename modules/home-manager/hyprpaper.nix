{ ... }:

{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "${assets/sean-afnan-244576.jpg}" ];
      wallpaper = [ ",${assets/sean-afnan-244576.jpg}" ];
      splash = false;
    };
  };
}
