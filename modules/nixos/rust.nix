{ pkgs, inputs, ... }:

{
  nixpkgs.overlays = [
    inputs.rust-overlay.overlays.default
  ];

  environment.systemPackages = with pkgs; [
    (rust-bin.fromRustupToolchainFile ./rust-toolchain.toml)
    cargo-watch
    cargo-udeps
    cargo-tauri
    sqlx-cli
    trunk
  ];
}
