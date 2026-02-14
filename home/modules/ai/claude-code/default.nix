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
  self = config.modules.ai.claude-code;
  xid-mcp-server = extra.xid-mcp-server.packages.${extra.system}.default;
in
{
  imports = [ ];
  options.modules.ai.claude-code = {
    enable = mkEnableOption "claude-code";
  };
  config = mkIf self.enable {
    home.packages = with pkgs; [
      claude-code
      claude-code-router
    ];
    home.file.".claude-code-router/config.json" = {
      source = ./router-config.json;
      enable = true;
    };
    home.file.".claude/settings.json" = {
      text = builtins.toJSON {
        "$schema" = "https://json.schemastore.org/claude-code-settings.json";
        "permissions" = {
          "allow" = [ ];
        };
        "enabledPlugins" = {
          "gopls-lsp@claude-plugins-official" = true;
        };
      };
      enable = true;
    };
    # HACK: MCPサーバーをユーザーレベルで指定する方法がまともに無い
    # https://github.com/anthropics/claude-code/issues/3321
    home.shellAliases = {
      "cl" = "claude --mcp-config ~/.claude/.mcp.json";
    };
    home.file.".claude/.mcp.json" = {
      text = builtins.toJSON {
        "mcpServers" = {
          "xid-mcp-server" = {
            "command" = "${xid-mcp-server}/bin/xid-mcp-server";
          };
          "ggn-github" = {
            type = "http";
            url = "https://api.githubcopilot.com/mcp";
            headers = {
              Authorization = "Bearer \${GGN_GITHUB_TOKEN}";
            };
          };
          "notion" = {
            type = "http";
            url = "https://mcp.notion.com/mcp";
          };
        };
      };
      enable = true;
    };
  };
}
