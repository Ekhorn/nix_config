{ inputs }:

{
  channels = import ./add-channels.nix { inherit inputs; };
  criterion-table = import ./criterion-table.nix;
}
