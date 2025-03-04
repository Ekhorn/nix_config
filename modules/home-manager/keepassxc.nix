{ pkgs, ... }:

{
  home.file = {
    ".config/keepassxc/keepassxc.ini".text = ''
      [General]
      ConfigVersion=2

      [Browser]
      CustomProxyLocation=
      Enabled=true

      [GUI]
      ApplicationTheme=dark
      HidePasswords=true
      MinimizeOnClose=true
      MinimizeOnStartup=true
      ShowTrayIcon=true
      TrayIconAppearance=monochrome-light

      [KeeShare]
      Active="<?xml version=\"1.0\"?><KeeShare><Active/></KeeShare>\n"
      QuietSuccess=true

      [PasswordGenerator]
      AdditionalChars=
      ExcludedChars=
    '';
  };
  home.packages = with pkgs; [ keepassxc ];
}
