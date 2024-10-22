{
  description = "Koen's NixOS Config";

  inputs = {
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { nixpkgs, ... } @ inputs:
  {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./bluetooth.nix
        ./bootloader.nix
        ./configuration.nix
        ./display-manager.nix
        ./fonts.nix
        #./gnome.nix
        ./hardware-configuration.nix
        ./hyprland.nix
        ./i18n.nix
        ./networking.nix
        ./nix-settings.nix
        ./nvidia.nix
        ./packages.nix
        ./rust.nix 
        ./security.nix
        ./services.nix
        ./ssh.nix
        ./time.nix
        ./users.nix
        ./variables.nix
        ./virtualization.nix
      ];
    };
  };
}
