{ inputs, ... }:

final: prev:
let
  inherit (prev) system;
in
{
  unstable = import inputs.unstable {
    inherit system;
    config = prev.config;
  };
  latest = import inputs.latest {
    inherit system;
    config = prev.config;
  };
}
