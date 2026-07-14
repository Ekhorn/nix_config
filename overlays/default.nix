{ inputs }:

let
  channels = import ./add-channels.nix { inherit inputs; };
  patches = import ./apply-patches.nix;
  criterion-table = import ./criterion-table.nix;
  virtui = import ./virtui.nix;
  vhs = import ./vhs.nix;
in
[
  channels
  criterion-table
  patches
  virtui
  vhs
]
