{ inputs, ... }:

final: prev: {
  unstable = import inputs.unstable {
    system = prev.stdenv.hostPlatform.system;
    config = prev.config;
  };
  latest = import inputs.latest {
    system = prev.stdenv.hostPlatform.system;
    config = prev.config;
  };
}
