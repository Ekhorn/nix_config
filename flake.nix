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
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "unstable";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.7.0";
    nixos-hardware.url = "github:NixOS/nixos-hardware/72674a6b5599e844c045ae7449ba91f803d44ebc";
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

      home-manager = inputs.home-manager.nixosModules.default;

      # Using nixpkgs.lib.systems.flakeExposed systems,
      # see https://github.com/NixOS/nixpkgs/blob/5d65a618c663db71662a434a3d5887f2ee7f0a1f/lib/systems/flake-systems.nix
      forAllSystems = f: builtins.mapAttrs f stable.legacyPackages;
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
      mkNixos =
        configuration: overlays:
        stable.lib.nixosSystem {
          modules = [
            configuration
            {
              nixpkgs.overlays = import overlays { inherit inputs; };
              # Let 'nixos-version --json' know about the Git revision of this flake.
              # Ref https://www.tweag.io/blog/2020-07-31-nixos-flakes/#hermetic-evaluation
              system.configurationRevision = stable.lib.mkIf (self ? rev) self.rev;
            }
          ];
          specialArgs = { inherit inputs outputs; };
        };
      mkPi =
        configuration: overlays:
        mkNixos {
          imports = [
            configuration
            inputs.nixos-hardware.nixosModules.raspberry-pi-4
          ];
        } overlays;
      mkShell = file: pkgs: import file { inherit pkgs; };
    in
    {
      devShells = forAllSystems (
        system: pkgs: {
          playwright = mkShell ./shells/playwright.nix pkgs;
        }
      );

      homeConfigurations = {
        "koen@laptop-koen" = mkHome ./hosts/laptop-koen/home.nix;
        "koen@pc-koen" = mkHome ./hosts/pc-koen/home.nix;
      };

      homeManagerModules = import ./modules/home-manager;

      nixosConfigurations = {
        emu = mkNixos ./hosts/emu/configuration.nix ./overlays;
        hetzner = mkAnywhere ./anywhere/hetzner/configuration.nix "/dev/sda";
        laptop-koen = mkNixos ./hosts/laptop-koen/configuration.nix ./overlays;
        pc-koen = mkNixos ./hosts/pc-koen/configuration.nix ./overlays;
        pi = mkPi ./hosts/pi/configuration.nix ./overlays;
        spaced-aws = mkAnywhere ./anywhere/spaced/aws/configuration.nix "/dev/xvda";
        spaced-do = mkAnywhere ./anywhere/spaced/do/configuration.nix null;
        spaced-gc = mkAnywhere ./anywhere/spaced/gc/configuration.nix "/dev/sda";
        spaced-hetzner = mkAnywhere ./anywhere/spaced/hetzner/configuration.nix "/dev/sda";
        spaced-ionos = mkAnywhere ./anywhere/spaced/ionos/configuration.nix null;
      };

      nixosModules = import ./modules/nixos;

      packages = forAllSystems (
        system: pkgs: builtins.mapAttrs (host: cfg: cfg.config.system.build.vm) self.nixosConfigurations
      );
    };
}
