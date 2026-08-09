{ pkgs, ... }:

{
  programs.zed-editor = {
    enable = true;
    mutableUserSettings = true;
    extensions = [
      "groovy"
      "java"
      "latex"
      "ltex"
      "mdx"
      "nix"
      "toml"
    ];
    package = pkgs.latest.zed-editor;
    themes = {
      dark = ./zed_dark.json;
    };
    userSettings = {
      auto_update = false;
      format_on_save = "off";

      ui_font_size = 14;
      buffer_font_size = 14;
      theme = {
        mode = "dark";
        light = "One Light";
        dark = "Zed Dark";
      };
      show_whitespaces = "all";
      soft_wrap = "editor_width";
      scrollbar = {
        axes = {
          horizontal = false;
        };
      };
      outline_panel = {
        button = false;
      };
      collaboration_panel = {
        button = false;
      };

      languages = {
        Nix = {
          language_servers = [
            "nil"
            "!nixd"
          ];
          formatter = {
            external = {
              command = "${pkgs.nixfmt-rs}/bin/nixfmt";
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

      language_models = {
        ollama = {
          api_url = "http://pc-koen:11435";
          auto_discover = true;
        };
      };

      agent = {
        default_model = {
          provider = "ollama";
          model = "qwen3.6:27b";
        };
        favorite_models = [
        ];
      };
    };
  };
}
