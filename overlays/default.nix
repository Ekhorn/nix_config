{ inputs }:

let
  channels = import ./add-channels.nix { inherit inputs; };
  patches = import ./apply-patches.nix;
in
[
  channels
  patches
]
