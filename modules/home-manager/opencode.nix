{ pkgs, ... }:

{
  programs.opencode = {
    enable = true;
    package = pkgs.unstable.opencode;
    settings = {
      autoshare = false;
      autoupdate = false;
      model = "qwen2.5-coder:7b-32k";
      permission = {
        read = "allow";
        edit = "ask";
        bash = "ask";
        webfetch = "ask";
      };
      provider = {
        ollama = {
          npm = "@ai-sdk/openai-compatible";
          name = "Ollama (local)";
          options = {
            baseURL = "http://pc-koen:11434/v1";
          };
          models = {
            "qwen2.5-coder:3b-32k" = {
              tools = true;
            };
            "qwen2.5-coder:7b-32k" = {
              tools = true;
            };
            "qwen2.5-coder:14b-32k" = {
              tools = true;
            };
            "gpt-oss:20b" = { };
            "llama3.2:3b" = { };
            "qwen3-vl:4b" = { };
            "qwen3-vl:8b" = { };
          };
        };
      };
      theme = "opencode";
    };
  };
}
