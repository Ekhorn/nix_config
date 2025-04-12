{ pkgs, ... }:

let
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
  hyprland-session = "${pkgs.hyprland}/share/wayland-sessions";
in
{
  environment.systemPackages = with pkgs; [
    greetd.tuigreet
  ];

  security.pam.services.greetd.enableGnomeKeyring = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${tuigreet} --time --time-format '%H:%M | %a * %h | %F' --remember --remember-session --sessions ${hyprland-session}";
        user = "koen";
      };
    };
  };
}
