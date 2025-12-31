{ inputs, ... }:

final: prev: {
  unstable = import inputs.unstable {
    system = final.stdenv.hostPlatform.system;
    config = final.config;
  };
  latest = import inputs.latest {
    system = final.stdenv.hostPlatform.system;
    config = final.config;
  };
}
