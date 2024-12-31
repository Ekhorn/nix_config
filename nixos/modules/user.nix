{ config, lib, pkgs, ... }:

{
  options = {
    user.enable = lib.mkEnableOption "Enable user module.";
    user.username = lib.mkOption {
      description = ''
        Set the users' username.
      '';
    };
  };

  config = lib.mkIf config.user.enable {
    users.users.${config.user.username} = {
      extraGroups = [ "networkmanager" "wheel" ];
      isNormalUser = true;
      packages = with pkgs; [
        adwaita-icon-theme
      ];
      shell = pkgs.zsh;
    };
  };
}

