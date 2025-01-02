{ pkgs, ... }:

{
  home.file = {
    ".config/keepassxc/keepassxc.ini".text = ''
      [General]
      ConfigVersion=2

      [GUI]
      ApplicationTheme=dark
      HidePasswords=true

      [PasswordGenerator]
      AdditionalChars=
      ExcludedChars=
    '';
  };
  home.packages = with pkgs; [ keepassxc ];
}
