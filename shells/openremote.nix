{
  pkgs ? import <nixpkgs> { },
}:

let
  commit = "145b67bd0bd4e075f981c1c2b81155d9e2982de2"; # 1.57.0
  sha256 = "sha256:152qwxacs6lw1dskn21985qly8ipjzwpsvicy7inzh3hhma603gg";
  playwrightShell = import ./playwright.nix { inherit pkgs commit sha256; };
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    protobuf
    grpc
  ];
  inputsFrom = [ playwrightShell ];
  packages = with pkgs; [
    openjdk21_headless
    nodejs_24
    corepack_24
  ];
  shellHook = ''
    ${playwrightShell.shellHook or ""}
  '';
}
