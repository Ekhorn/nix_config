{ inputs }:

let
  channels = import ./add-channels.nix { inherit inputs; };
  patches = import ./apply-patches.nix;
  criterion-table = import ./criterion-table.nix;
in
[
  channels
  criterion-table
  patches
]
