{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    settings = {
      theme = "dark_plus";
      editor = {
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
        soft-wrap.enable = true;
      };
    };
    # themes = {
    #   autumn_night_transparent = {
    #     "inherits" = "autumn_night";
    #     "ui.background" = { };
    #   };
    # };
    languages = {
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
        }
        {
          name = "rust";
          language-servers = [ "rust-analyzer" ];
        }
        {
          name = "java";
          language-servers = [ "jdtls" ];
        }
        {
          name = "typescript";
          roots = [
            "deno.json"
            "deno.jsonc"
            "package.json"
          ];
          file-types = [
            "ts"
            "tsx"
          ];
          auto-format = true;
          language-servers = [ "deno-lsp" ];
        }
        {
          name = "javascript";
          roots = [
            "deno.json"
            "deno.jsonc"
            "package.json"
          ];
          file-types = [
            "js"
            "jsx"
          ];
          auto-format = true;
          language-servers = [ "deno-lsp" ];
        }
      ];
      language-server = {
        jdtls = {
          command = "${pkgs.jdt-language-server}/bin/jdtls";
        };
        deno-lsp = {
          command = "deno";
          args = [ "lsp" ];
          config.deno.enable = true;
        };
      };
    };
  };
}
