{
  lib,
  config,
  pkgs,
  ...
}:

with builtins;
with lib;
let
  self = config.modules.ai.crush;
in
{
  imports = [ ];
  options.modules.ai.crush = {
    enable = mkEnableOption "crush";
  };
  config = mkIf self.enable {
    programs.crush = {
      enable = true;
      settings = {
        models = {
          large = {
            model = "gemini-3-flash-preview";
            provider = "gemini";
            max_tokens = 500000;
            reasoning_effort = "high";
          };
          small = {
            model = "gemini-3-flash-preview";
            provider = "gemini";
            max_tokens = 128000;
            reasoning_effort = "medium";
          };
        };
        lsp = {
          go = {
            command = "gopls";
          };
          typescript = {
            command = "typescript-language-server";
            args = [
              "--stdio"
            ];
          };
        };
        mcp = {
          "mcp-obsidian" = {
            type = "stdio";
            command = "uvx";
            args = [
              "mcp-obsidian"
            ];
            env = {
              # NOTE: just for local api
              OBSIDIAN_API_KEY = "1a429cf6a4911b1d478b9964f1b8c3d684c1af81ad96494b0867e6834b47df97";
              OBSIDIAN_HOST = "127.0.0.1";
              OBSIDIAN_PORT = "27124";
              PYTHONUTF8 = "1";
            };
          };
        };
        providers = {
          ollama = {
            id = "ollama";
            name = "Ollama";
            base_url = "http://192.168.1.16:11434/v1/";
            type = "openai";
            models = [
              {
                name = "qwen3:30b-instruct_q4_k_xl";
                id = "SimonPu/Qwen3-Coder:30B-Instruct_Q4_K_XL";
                context_window = 256000;
                default_max_tokens = 200000;
              }
            ];
          };
        };
      };
    };
  };
}
