{ pkgs, util, ... }:

{
  programs.zed-editor = {
    enable = true;
    mutableUserSettings = false;
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
      # vim_mode = true;
      show_whitespaces = "all";
      soft_wrap = "editor_width";
      scrollbar = {
        axes = {
          horizontal = false;
        };
      };
      # project_panel = {
      #   scrollbar = {
      #     show = "never";
      #   };
      # };
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

      language_models =
        let
          ollama =
            {
              supports ? [ ],
              ...
            }@extras:
            (builtins.removeAttrs extras [ "supports" ])
            // util.attrFromList {
              prefix = "supports_";
              features = supports;
              value = true;
            };
        in
        {
          ollama = {
            api_url = "http://192.168.223.107:11434";
            auto_discover = false;
            available_models = map ollama [
              {
                name = "qwen3.6:35b";
                max_tokens = 262144;
                supports = [
                  "tools"
                  "thinking"
                ];
              }
              {
                name = "qwen3.6:27b";
                max_tokens = 262144;
                supports = [
                  "tools"
                  "thinking"
                ];
              }
              {
                name = "qwen3-coder:30b";
                max_tokens = 262144;
                supports = [ "tools" ];
              }
              {
                name = "gpt-oss:20b";
                max_tokens = 131072;
                supports = [
                  "tools"
                  "thinking"
                ];
              }
            ];
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
