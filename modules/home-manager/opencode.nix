{ ... }:

{
  programs.opencode = {
    enable = true;
    settings = {
      autoshare = false;
      autoupdate = true;
      model = "llama2";
      provider = {
        ollama = {
          npm = "@ai-sdk/openai-compatible";
          name = "Ollama (local)";
          options = {
            baseURL = "http://pc-koen:11434/v1";
          };
          models = {
            "llama3.2:3b" = {
              name = "Llama 3.2";
            };
          };
        };
      };
      theme = "opencode";
    };
  };
}
