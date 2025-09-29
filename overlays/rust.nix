self: super: {
  mkRustCrate =
    {
      pname,
      version,
      owner,
      repo,
      sha256,
      cargoHash,
      description,
      homepage,
      mainProgram ? pname,
    }:
    super.rustPlatform.buildRustPackage rec {
      inherit pname version cargoHash;

      src = super.fetchFromGitHub {
        inherit owner repo;
        rev = version;
        sha256 = sha256;
      };

      meta = with super.lib; {
        inherit description homepage;
        mainProgram = mainProgram;
        license = with licenses; [
          mit
          asl20
        ];
      };
    };

  criterion-table = self.mkRustCrate {
    pname = "criterion-table";
    version = "master";
    owner = "Ekhorn";
    repo = "criterion-table";
    sha256 = "sha256-M1nKKhEFpJA2rPa3RE5bNNdEcWdi9z2S8cNizmnPmaY=";
    cargoHash = "sha256-YiL2+OJuudfsH/QIdUcOgfLntzRet5CinmIvhyllN7M=";
    description = "";
    homepage = "https://github.com/Ekhorn/criterion-table";
    mainProgram = "criterion-table";
  };
}
