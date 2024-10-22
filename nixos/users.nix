{ pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.koen = {
    isNormalUser = true;
    description = "koen";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      adwaita-icon-theme
    ];
    shell = pkgs.zsh;
  };
}
