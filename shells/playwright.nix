{ pkgs }:

let
  commmit = builtins.getEnv "NIXPKGS_COMMIT";
  src =
    if commmit != "" then
      fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/${commmit}.tar.gz";
      }
    else
      pkgs.path;
  playwright-driver = (import src { inherit (pkgs) system; }).playwright-driver;
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
