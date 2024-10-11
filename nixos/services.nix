{ pkgs, ... }:

{
  programs.dconf.enable = true;
  programs.zsh.enable = true;
  programs.direnv.enable = true;

  # TODO: doesn't work
  services.logind.extraConfig = ''
    HandlePowerKey=ingore
  '';
  #services.spice-vdagentd.enable = true;
  #services.qemuGuest.enable = true;
  #services.xserver.videoDrivers = ["intel"];
  services.syncthing = {
    enable = true;
    user = "koen";
    configDir = "/home/koen/.local/state/syncthing";
  };
  # Allow non-root access to update screen backlight brightness
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"
  '';
}
