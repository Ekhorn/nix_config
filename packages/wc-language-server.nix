{ pkgs }:

pkgs.stdenv.mkDerivation (finalAttrs: {
  pname = "wc-language-server";
  version = "0.0.6";

  src = pkgs.fetchFromGitHub {
    owner = "wc-toolkit";
    repo = "wc-language-server";
    tag = "@wc-toolkit/language-server@0.0.6";
    sha256 = "sha256-9HjEUokJB5Z/hg0HR/azIIM5Dfxa27jyN0vO7POYbNg=";
  };

  nativeBuildInputs = with pkgs; [
    nodejs
    pnpm.configHook
    bun
  ];

  pnpmWorkspaces = [ "@wc-toolkit/language-server" ];
  pnpmDeps = pkgs.pnpm.fetchDeps {
    inherit (finalAttrs) pname version src;
    fetcherVersion = 3;
    hash = "sha256-19UfrA1lTQ3dwG50eHlcTORAplha/0rt+RwT3fPv9XE=";
  };

  buildPhase = ''
    cd packages/language-server/
    node scripts/build-single-file.mjs
    # bun build dist/wc-language-server.bundle.cjs --compile --outfile bin/wc-language-server
    # chmod +x bin/wc-language-server
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp -r dist/* $out/bin/
  '';
})
