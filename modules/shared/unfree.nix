{
  config,
  lib,
  ...
}:

{
  options = {
    unfree.enable = lib.mkEnableOption "Enable unfree module.";
    unfree.packages = lib.mkOption {
      default = [ ];
      description = "Whitelist unfree packages";
    };
  };

  config = lib.mkIf config.unfree.enable {
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) config.unfree.packages;
  };
}
