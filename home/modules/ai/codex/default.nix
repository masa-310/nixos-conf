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
  self = config.modules.ai.codex;
  xid-mcp-server = extra.xid-mcp-server.packages.${extra.system}.default;
  tomlFormat = pkgs.formats.toml { };
in
{
  imports = [ ];
  options.modules.ai.codex = {
    enable = mkEnableOption "codex";
  };
  config = mkIf self.enable {
    home.packages = with pkgs; [
      codex
    ];
    home.file.".codex/config.toml" = {
      source = tomlFormat.generate "codex-config" {
        "mcp_servers" = {
          "xid-mcp-server" = {
            "command" = "${xid-mcp-server}/bin/xid-mcp-server";
          };
          slack = {
            command = "npx";
            args = [
              "-y"
              "@modelcontextprotocol/server-slack"
            ];
            env = {
              SLACK_BOT_TOKEN = "\${SLACK_BOT_TOKEN}";
              SLACK_TEAM_ID = "\${SLACK_TEAM_ID}";
              SLACK_CHANNEL_IDS = "\${SLACK_CHANNEL_IDS}";
            };
          };
          playwright = {
            command = "mcp-server-playwright";
            args = [
              "--browser"
              "chromium"
            ];
          };
          "ggn-github" = {
            type = "http";
            url = "https://api.githubcopilot.com/mcp";
            headers = {
              Authorization = "Bearer \${GGN_GITHUB_TOKEN}";
            };
          };
          notion = {
            type = "http";
            url = "https://mcp.notion.com/mcp";
          };
          linear = {
            type = "http";
            url = "https://mcp.linear.app/mcp";
          };
          mcp-gemini-cli = {
            command = "npx";
            args = [
              "-y"
              "mcp-gemini-cli@0.3.1"
              "--allow-npx"
            ];
          };
          codex = {
            command = "codex";
            args = [ "mcp-server" ];
          };
        };
      };
      enable = true;
    };
  };
}
