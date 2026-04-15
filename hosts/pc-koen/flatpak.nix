{ pkgs, ... }:

{
  # services.flatpak.remotes = lib.mkOptionDefault [{
  #   name = "flathub-beta";
  #   location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
  # }];

  # services.flatpak.update.auto.enable = false;
  # services.flatpak.uninstallUnmanaged = false;
  services.flatpak.enable = true;
  services.flatpak.packages = [
    rec {
      appId = "com.hypixel.HytaleLauncher";
      sha256 = "sha256-ZlsBaIqa0GaTci7QkRnwfcAByS4CL5osXba2p0gE+CQ=";
      bundle = "${pkgs.fetchurl {
        url = "https://launcher.hytale.com/builds/release/linux/amd64/hytale-launcher-latest.flatpak";
        inherit sha256;
      }}";
    }
  ];
}
