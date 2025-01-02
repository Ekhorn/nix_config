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

  outputs = { self, stable, home-manager, ... } @ inputs:
  let
    inherit (self) outputs;

    system = "x86_64-linux";
    stable_x86 = stable.legacyPackages.${system};
    #unstable_x86 = unstable.legacyPackages.${system};
    home-manager = inputs.home-manager.nixosModules.default;

    mkNixos = modules:
      stable.lib.nixosSystem {
        inherit modules;
        specialArgs = { inherit inputs outputs; };
      };
    mkHome = modules: pkgs:
      home-manager.lib.homeManagerConfiguration {
        inherit modules pkgs;
        extraSpecialArgs = { inherit inputs outputs; };
      };
  in
  {
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;

    nixosConfigurations = {
      pc-koen = mkNixos [./hosts/pc-koen/configuration.nix];
      laptop-koen = mkNixos [./hosts/laptop/configuration.nix];
    };

    homeConfigurations = {
      "koen@pc-koen" = mkHome [./hosts/pc-koen/home.nix] stable_x86;
      "koen@laptop-koen" = mkHome [./hosts/laptop/home.nix] stable_x86;
    };
  };
}