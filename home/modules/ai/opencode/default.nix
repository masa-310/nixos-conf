{
  lib,
  config,
  pkgs,
  extra,
  ...
}:

with builtins;
with lib;
let
  self = config.modules.ai.opencode;
  xid-mcp-server = extra.xid-mcp-server.packages.${extra.system}.default;
in
{
  imports = [ ];
  options.modules.ai.opencode = {
    enable = mkEnableOption "opencode";
  };
  config = mkIf self.enable {
    home.packages = [
      pkgs.opencode
    ];
    xdg.configFile = {
      "opencode/opencode.json" = {
        text = builtins.toJSON {
          "$schema" = "https://opencode.ai/config.json";
          theme = "opencode";
          model = "google/gemini-3-flash-preview";
          small_model = "google/gemin-2.5-flash";
          mcp = {
            mcp-obsidian = {
              enabled = true;
              type = "local";
              command = [
                "uvx"
                "mcp-obsidian"
              ];
              environment = {
                OBSIDIAN_API_KEY = "1a429cf6a4911b1d478b9964f1b8c3d684c1af81ad96494b0867e6834b47df97";
                OBSIDIAN_HOST = "127.0.0.1";
                OBSIDIAN_PORT = "27124";
                PYTHONUTF8 = "1";
              };
            };
            github = {
              enabled = false;
              type = "remote";
              url = "https://api.githubcopilot.com/mcp/";
              headers = {
                Authorization = "Bearer {env:GITHUB_TOKEN}";
              };
            };
            ggn-github = {
              enabled = true;
              type = "remote";
              url = "https://api.githubcopilot.com/mcp/";
              headers = {
                Authorization = "Bearer {env:GGN_GITHUB_TOKEN}";
              };
            };
            xid-mcp-server = {
              enabled = true;
              type = "local";
              command = [ "${xid-mcp-server}/bin/xid-mcp-server" ];
            };
          };
        };
        enable = true;
      };
      "opencode/skills".source = ./config/skills;
      "opencode/agent".source = ./config/agent;
    };
  };
}
