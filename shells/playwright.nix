{ pkgs }:

let
  package =
    import
      (fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/e462a75ad44682b4e8df740e33fca4f048e8aa11.tar.gz";
        sha256 = "1q4h9z3fkrz4bzi66d6p9b865rj5hd7y4krnpg48f7pagyxvvn02";
      })
      {
        inherit (pkgs) system;
      };
  playwright-driver = package.playwright-driver;
in
pkgs.mkShell {
  nativeBuildInputs = [ playwright-driver ];

  shellHook = ''
    export PLAYWRIGHT_BROWSERS_PATH=${playwright-driver.browsers}
    export PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS=true
    # Required for Webkit
    export PLAYWRIGHT_HOST_PLATFORM_OVERRIDE="ubuntu-24.04"
  '';
}
