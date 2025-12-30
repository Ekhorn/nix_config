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

      # Also consider nixpkgs.lib.systems.flakeExposed
      # see https://github.com/NixOS/nixpkgs/blob/5d65a618c663db71662a434a3d5887f2ee7f0a1f/lib/systems/flake-systems.nix
      # or see https://github.com/numtide/flake-utils/blob/11707dc2f618dd54ca8739b309ec4fc024de578b/allSystems.nix
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      home-manager = inputs.home-manager.nixosModules.default;

      mkNixos =
        configuration:
        stable.lib.nixosSystem {
          modules = [ configuration ];
          specialArgs = { inherit inputs outputs; };
        };
      mkAnywhere =
        configuration: device:
        stable.lib.nixosSystem {
          modules = [
            configuration
            {
              disko.devices.disk.main.device = if device != null then device else "/dev/vda";
            }
          ];
          specialArgs = { inherit inputs outputs; };
        };
      mkHome =
        configuration:
        home-manager.lib.homeManagerConfiguration {
          # inherit pkgs; # Already "applied" with `home-manager.useGlobalPkgs = true;`
          modules = [ configuration ];
          extraSpecialArgs = { inherit inputs outputs; };
        };
      mkShell =
        file: pkgs: system:
        import file { pkgs = pkgs.legacyPackages.${system}; };
      applyPatches =
        name: patches:
        stable.${name}.overrideAttrs (old: {
          patches = (old.patches or [ ]) ++ patches;
        });
      forAllSystems = function: stable.lib.genAttrs systems function;
    in
    {
      devShells = forAllSystems (system: {
        playwright = mkShell ./shells/playwright.nix stable system;
      });

      homeConfigurations = {
        "koen@pc-koen" = mkHome ./hosts/pc-koen/home.nix;
        "koen@laptop-koen" = mkHome ./hosts/laptop-koen/home.nix;
      };

      homeManagerModules = import ./modules/home-manager;

      nixosConfigurations = {
        pc-koen = mkNixos ./hosts/pc-koen/configuration.nix;
        laptop-koen = mkNixos ./hosts/laptop-koen/configuration.nix;
        qemu = mkNixos ./hosts/spaced/qemu/configuration.nix;
        hetzner = mkAnywhere ./anywhere/hetzner/configuration.nix "/dev/sda";
        "spaced/aws" = mkAnywhere ./anywhere/spaced/aws/configuration.nix "/dev/xvda";
        "spaced/do" = mkAnywhere ./anywhere/spaced/do/configuration.nix null;
        "spaced/gc" = mkAnywhere ./anywhere/spaced/gc/configuration.nix "/dev/sda";
        "spaced/hetzner" = mkAnywhere ./anywhere/spaced/hetzner/configuration.nix "/dev/sda";
        "spaced/ionos" = mkAnywhere ./anywhere/spaced/ionos/configuration.nix null;
      };

      nixosModules = import ./modules/nixos;

      overlays = [
        (import ./overlays/add-channels.nix { inherit inputs; })
        (import ./overlays/rust.nix)
      ];

      packages = {
        libfprint = applyPatches "libfprint" [ ./patches/goodix-60c2.patch ];
      };
    };
}
