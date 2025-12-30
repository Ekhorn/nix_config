{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    user.enable = lib.mkEnableOption "Enable user option.";
    user.username = lib.mkOption {
      description = ''
        Set the users' username.
      '';
    };
    user.extraGroups = lib.mkOption {
      default = [
        "networkmanager"
        "wheel"
      ];
      description = ''
        Set the users' extraGroups.
      '';
    };
    user.extraKeys = lib.mkOption {
      default = [ ];
      description = ''
        Set the users' extra trusted SSH keys.
      '';
    };
    user.shell = lib.mkOption {
      default = pkgs.zsh;
      description = ''
        Set the users' shell.
      '';
    };
  };

  config = lib.mkIf config.user.enable {
    users.users.${config.user.username} = {
      extraGroups = config.user.extraGroups;
      isNormalUser = true;
      openssh.authorizedKeys.keys =
        config.user.extraKeys ++ (lib.strings.splitString "\n" (builtins.readFile ./authorized_keys));
      shell = config.user.shell;
    };
  };
}
