{ pkgs, ... }:

{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "groovy"
      "java"
      "nix"
      "toml"
      "latex"
      "ltex"
    ];
    package = pkgs.unstable.zed-editor-fhs;
    userSettings = {
      hour_format = "hour24";
      auto_update = false;

      ui_font_size = 16;
      buffer_font_size = 16;
      theme = {
        mode = "dark";
        light = "One Light";
        dark = "One Dark";
      };
      # vim_mode = true;
      show_whitespaces = "all";
      soft_wrap = "editor_width";

      languages = {
        Nix = {
          language_servers = [
            "nil"
            "!nixd"
          ];
          formatter = {
            external = {
              command = "nixfmt";
              arguments = [
                "--quiet"
                "--"
              ];
            };
          };
        };
      };

      lsp = {
        texlab = {
          settings = {
            texlab = {
              build = {
                onSave = true;
                forwardSearchAfter = true;
                executable = "pdflatex";
                args = [
                  "-synctex=1"
                  "-recorder"
                  "%f"
                ];
              };
              forwardSearch = {
                executable = "zathura";
                args = [
                  "--synctex-forward"
                  "%l:1:%f"
                  "-x"
                  "zed %%{input}:%%{line}"
                  "%p"
                ];
              };
            };
          };
        };
      };
    };
  };
}
