{
  description = "My NixOS config";
  inputs = {
    stable.url = "github:NixOS/nixpkgs/nixos-24.11";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "stable";
    };
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { stable, ... } @ inputs:
  let
    system = "x86_64-linux";
    pkgs-unstable = inputs.unstable.legacyPackages.${system};
    home-manager = inputs.home-manager.nixosModules.default;
  in
  {
    nixosConfigurations = {
      pc-koen = stable.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/default/configuration.nix
          home-manager
        ];
      };
      laptop-koen = stable.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/laptop/configuration.nix
          home-manager
        ];
      };
    };
  };
}
