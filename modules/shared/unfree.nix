{
  config,
  lib,
  ...
}:

{
  options = {
    unfree.enable = lib.mkEnableOption "Enable unfree option.";
    unfree.packages = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = ''
        Whitelist unfree packages

        Note: Only works in home-manager if `home-manager.useGlobalPkgs = false;` as home-manager
        disables `nixpkgs.*` options.
      '';
    };
  };

  config = lib.mkIf config.unfree.enable {
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) config.unfree.packages;
  };
}
