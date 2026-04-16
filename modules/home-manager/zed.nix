{ pkgs, ... }:

{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "groovy"
      "java"
      "latex"
      "ltex"
      "mdx"
      "nix"
      "toml"
    ];
    package = pkgs.unstable.zed-editor;
    themes = {
      dark = ./zed_dark.json;
    };
    userSettings = {
      hour_format = "hour24";
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
      notification_panel = {
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

      agent = {
        default_model = {
          provider = "google";
          model = "gemini-3.1-pro-preview";
          enable_thinking = true;
        };
        favorite_models = [
          {
            provider = "google";
            model = "gemini-3.1-pro-preview";
            enable_thinking = true;
          }
          {
            provider = "Mammouth AI";
            model = "claude-sonnet-4-5";
          }
        ];
        model_parameters = [ ];
      };
      language_models = {
        openai_compatible = {
          "Mammouth AI" = {
            api_url = "https://api.mammouth.ai/v1";
            available_models = [
              # --- GPT Models ---
              {
                name = "gpt-4.1";
                display_name = "GPT 4.1";
                max_tokens = 1047576;
                max_output_tokens = 32768;
                max_completion_tokens = 1047576;
              }
              {
                name = "gpt-4.1-mini";
                display_name = "GPT 4.1 Mini";
                max_tokens = 1047576;
                max_output_tokens = 32768;
                max_completion_tokens = 1047576;
              }
              {
                name = "gpt-4.1-nano";
                display_name = "GPT 4.1 Nano";
                max_tokens = 1047576;
                max_output_tokens = 32768;
                max_completion_tokens = 1047576;
              }
              {
                name = "gpt-4o";
                display_name = "GPT 4o";
                max_tokens = 128000;
                max_output_tokens = 16384;
                max_completion_tokens = 128000;
              }
              {
                name = "o4-mini";
                display_name = "o4 Mini";
                max_tokens = 200000;
                max_output_tokens = 100000;
                max_completion_tokens = 200000;
              }
              {
                name = "gpt-5-mini";
                display_name = "GPT 5 Mini";
                max_tokens = 272000;
                max_output_tokens = 128000;
                max_completion_tokens = 272000;
              }
              {
                name = "gpt-5-nano";
                display_name = "GPT 5 Nano";
                max_tokens = 272000;
                max_output_tokens = 128000;
                max_completion_tokens = 272000;
              }
              {
                name = "gpt-5-chat";
                display_name = "GPT 5 Chat";
                max_tokens = 128000;
                max_output_tokens = 16384;
                max_completion_tokens = 128000;
              }
              {
                name = "gpt-5.1-chat";
                display_name = "GPT 5.1 Chat";
                max_tokens = 128000;
                max_output_tokens = 128000;
                max_completion_tokens = 128000;
              }
              {
                name = "gpt-5.2-chat";
                display_name = "GPT 5.2 Chat";
                max_tokens = 128000;
                max_output_tokens = 16384;
                max_completion_tokens = 128000;
              }

              # --- Mistral Models ---
              {
                name = "mistral-medium-3";
                display_name = "Mistral Medium 3";
                max_tokens = 160000;
              }
              {
                name = "mistral-medium-3.1";
                display_name = "Mistral Medium 3.1";
                max_tokens = 160000;
              }
              {
                name = "mistral-large-2411";
                display_name = "Mistral Large 2411";
                max_tokens = 160000;
              }
              {
                name = "mistral-large-3";
                display_name = "Mistral Large 3";
                max_tokens = 160000;
              }
              {
                name = "mistral-small-3.2-24b-instruct";
                display_name = "Mistral Small 3.2 24b Instruct";
                max_tokens = 32000;
              }
              {
                name = "codestral-2508";
                display_name = "Codestral 2508";
                max_tokens = 160000;
              }
              {
                name = "magistral-medium-2506";
                display_name = "Magistral Medium 2506";
                max_tokens = 160000;
              }
              {
                name = "magistral-medium-2506-thinking";
                display_name = "Magistral Medium 2506 Thinking";
                max_tokens = 160000;
              }

              # --- Claude Models ---
              {
                name = "claude-4-sonnet-20250522";
                display_name = "Claude 4 Sonnet";
                max_tokens = 160000;
              }
              {
                name = "claude-opus-4-1-20250805";
                display_name = "Claude Opus 4.1";
                max_tokens = 200000;
                max_output_tokens = 32000;
                max_completion_tokens = 200000;
              }
              {
                name = "claude-haiku-4-5";
                display_name = "Claude Haiku 4.5";
                max_tokens = 200000;
                max_output_tokens = 64000;
                max_completion_tokens = 200000;
              }
              {
                name = "claude-sonnet-4-5";
                display_name = "Claude Sonnet 4.5";
                max_tokens = 200000;
                max_output_tokens = 64000;
                max_completion_tokens = 200000;
              }
              {
                name = "claude-opus-4-5";
                display_name = "Claude Opus 4.5";
                max_tokens = 200000;
                max_output_tokens = 64000;
                max_completion_tokens = 200000;
              }

              # --- Grok Models ---
              {
                name = "grok-3";
                display_name = "Grok 3";
                max_tokens = 160000;
              }
              {
                name = "grok-3-mini";
                display_name = "Grok 3 Mini";
                max_tokens = 160000;
              }
              {
                name = "grok-4-0709";
                display_name = "Grok 4 0709";
                max_tokens = 256000;
                max_output_tokens = 256000;
                max_completion_tokens = 256000;
              }
              {
                name = "grok-4-fast-non-reasoning";
                display_name = "Grok 4 Fast Non Reasoning";
                max_tokens = 160000;
              }
              {
                name = "grok-code-fast-1";
                display_name = "Grok Code Fast 1";
                max_tokens = 160000;
              }

              # --- Gemini Models ---
              {
                name = "gemini-2.5-flash";
                display_name = "Gemini 2.5 Flash";
                max_tokens = 1048576;
                max_output_tokens = 8192;
                max_completion_tokens = 1048576;
              }
              {
                name = "gemini-2.5-pro";
                display_name = "Gemini 2.5 Pro";
                max_tokens = 1048576;
                max_output_tokens = 8192;
                max_completion_tokens = 1048576;
              }
              {
                name = "gemini-2.5-flash-image";
                display_name = "Gemini 2.5 Flash Image";
                max_tokens = 160000;
              }
              {
                name = "gemini-3-pro-preview";
                display_name = "Gemini 3 Pro Preview";
                max_tokens = 1048576;
                max_output_tokens = 65535;
                max_completion_tokens = 1048576;
              }
              {
                name = "gemini-3-pro-image-preview";
                display_name = "Gemini 3 Pro Image Preview";
                max_tokens = 160000;
              }

              # --- DeepSeek Models ---
              {
                name = "deepseek-r1-0528";
                display_name = "Deepseek R1 0528";
                max_tokens = 65336;
                max_output_tokens = 8192;
                max_completion_tokens = 65336;
              }
              {
                name = "deepseek-v3-0324";
                display_name = "Deepseek V3 0324";
                max_tokens = 65536;
                max_output_tokens = 8192;
                max_completion_tokens = 65536;
              }
              {
                name = "deepseek-v3.1";
                display_name = "Deepseek V3.1";
                max_tokens = 163840;
                max_output_tokens = 163840;
                max_completion_tokens = 163840;
              }
              {
                name = "deepseek-v3.1-terminus";
                display_name = "Deepseek V3.1 Terminus";
                max_tokens = 160000;
              }
              {
                name = "deepseek-v3.2-exp";
                display_name = "Deepseek V3.2 Exp";
                max_tokens = 163840;
                max_output_tokens = 163840;
                max_completion_tokens = 163840;
              }
              {
                name = "deepseek-v3.2";
                display_name = "Deepseek V3.2";
                max_tokens = 163840;
                max_output_tokens = 163840;
                max_completion_tokens = 163840;
              }

              # --- Llama Models ---
              {
                name = "llama-4-maverick";
                display_name = "Llama 4 Maverick";
                max_tokens = 160000;
              }
              {
                name = "llama-4-scout";
                display_name = "Llama 4 Scout";
                max_tokens = 160000;
              }

              # --- Kimi Models ---
              {
                name = "kimi-k2-instruct";
                display_name = "Kimi K2 Instruct";
                max_tokens = 160000;
              }
              {
                name = "kimi-k2-thinking";
                display_name = "Kimi K2 Thinking";
                max_tokens = 160000;
              }

              # --- Qwen Models ---
              {
                name = "qwen3-coder";
                display_name = "Qwen3 Coder";
                max_tokens = 262100;
                max_output_tokens = 262100;
                max_completion_tokens = 262100;
              }
              {
                name = "qwen3-coder-flash";
                display_name = "Qwen3 Coder Flash";
                max_tokens = 160000;
              }
              {
                name = "qwen3-coder-plus";
                display_name = "Qwen3 Coder Plus";
                max_tokens = 160000;
              }
            ];
          };
        };
      };

      profiles = {
        auto_format = {
          format_on_save = "on";
        };
      };
      # End of user_settings
    };
  };
}
