{
  description = "My NixOS config";
  inputs = {
    stable.url = "github:NixOS/nixpkgs/nixos-25.11";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    latest.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "stable";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "stable";
    };
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs =
    {
      self,
      stable,
      unstable,
      latest,
      home-manager,
      disko,
      ...
    }@inputs:
    let
      inherit (self) outputs;

      system = "x86_64-linux";
      stable_x86 = stable.legacyPackages.${system};
      home-manager = inputs.home-manager.nixosModules.default;

      mkNixos =
        configuration:
        stable.lib.nixosSystem {
          modules = [ configuration ];
          specialArgs = { inherit inputs outputs; };
        };
      mkAnywhere =
        configuration: system: device:
        stable.lib.nixosSystem {
          inherit system;
          modules = [
            configuration
            {
              disko.devices.disk.main.device = if device != null then device else "/dev/vda";
            }
          ];
          specialArgs = { inherit inputs outputs; };
        };
      mkHome =
        configuration: pkgs:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ configuration ];
          extraSpecialArgs = { inherit inputs outputs; };
        };
      mkShell = file: pkgs: import file { inherit pkgs; };
      applyPatches =
        name: patches:
        stable.${name}.overrideAttrs (old: {
          patches = (old.patches or [ ]) ++ patches;
        });
    in
    {
      devShells.${system} = {
        playwright = mkShell ./shells/playwright.nix stable_x86;
      };

      homeConfigurations = {
        "koen@pc-koen" = mkHome ./hosts/pc-koen/home.nix stable_x86;
        "koen@laptop-koen" = mkHome ./hosts/laptop-koen/home.nix stable_x86;
      };

      homeManagerModules = import ./modules/home-manager;

      nixosConfigurations = {
        pc-koen = mkNixos ./hosts/pc-koen/configuration.nix;
        laptop-koen = mkNixos ./hosts/laptop-koen/configuration.nix;
        qemu = mkNixos ./hosts/spaced/qemu/configuration.nix;
        hetzner = mkAnywhere ./anywhere/hetzner/configuration.nix "aarch64-linux" "/dev/sda";
        "spaced/aws" = mkAnywhere ./anywhere/spaced/aws/configuration.nix system "/dev/xvda";
        "spaced/do" = mkAnywhere ./anywhere/spaced/do/configuration.nix system null;
        "spaced/gc" = mkAnywhere ./anywhere/spaced/gc/configuration.nix system "/dev/sda";
        "spaced/hetzner" = mkAnywhere ./anywhere/spaced/hetzner/configuration.nix system "/dev/sda";
        "spaced/ionos" = mkAnywhere ./anywhere/spaced/ionos/configuration.nix system null;
      };

      nixosModules = import ./modules/nixos;

      overlays = [
        (import ./overlays/pkgs.nix { inherit inputs; })
        (import ./overlays/rust.nix)
      ];

      packages = {
        libfprint = applyPatches "libfprint" [ ./patches/goodix-60c2.patch ];
      };
    };
}
