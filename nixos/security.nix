{ ... }:

{
  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;
}
