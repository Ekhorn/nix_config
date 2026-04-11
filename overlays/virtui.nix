final: prev: {
  virtui =
    (builtins.getFlake "github:Ekhorn/virtui/ae48af480ec1a7de63e14bde6bbe83f8ab249a82")
    .packages.${final.stdenv.hostPlatform.system}.default;
}
