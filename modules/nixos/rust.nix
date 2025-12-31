{
  pkgs,
  inputs,
  outputs,
  ...
}:

{
  nixpkgs.overlays = [
    inputs.rust-overlay.overlays.default
    outputs.overlays.criterion-table
  ];

  environment.systemPackages = with pkgs; [
    (rust-bin.fromRustupToolchainFile ./rust-toolchain.toml)
    cargo-watch
    cargo-udeps
    cargo-tauri
    cargo-criterion
    criterion-table
    sqlx-cli
    trunk
  ];
}
