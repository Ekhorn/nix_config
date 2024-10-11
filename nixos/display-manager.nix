{ pkgs, ... }:

{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --time-format '%H:%M | %a * %h | %F' --cmd hyprland";
        user = "koen";
      };
    };
  };
}
