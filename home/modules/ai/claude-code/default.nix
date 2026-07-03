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
  browsers =
    (builtins.fromJSON (builtins.readFile "${pkgs.playwright-driver}/browsers.json")).browsers;
  chromium-rev = (builtins.head (builtins.filter (x: x.name == "chromium") browsers)).revision;
  chrome-exec-path="${pkgs.playwright.browsers}/chromium-${chromium-rev}/chrome-linux64/chrome";

  # Stopフックは本文を直接渡してくれないので、transcript(JSONL)から
  # 最後のassistantテキストを抜き出して通知bodyに載せる
  stop-notify = pkgs.writeShellScript "claude-stop-notify" ''
    input=$(cat)
    transcript=$(${pkgs.jq}/bin/jq -r '.transcript_path // empty' <<<"$input")
    body="タスクが完了しました"
    if [ -n "$transcript" ] && [ -f "$transcript" ]; then
      msg=$(${pkgs.jq}/bin/jq -rs '
        [ .[]
          | select(.type == "assistant")
          | .message.content[]?
          | select(.type == "text")
          | .text
        ] | last // empty
      ' "$transcript")
      if [ -n "$msg" ]; then
        body=''${msg:0:200}
        [ "''${#msg}" -gt 200 ] && body="$body…"
      fi
    fi
    ${pkgs.libnotify}/bin/notify-send "Claude Code" "$body"
  '';

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
        "hooks" = {
          "Stop" = [
            {
              "hooks" = [
                {
                  "type" = "command";
                  "command" = "${stop-notify}";
                }
              ];
            }
          ];
        };
      };
      enable = true;
    };
    # HACK: MCPサーバーをユーザーレベルで指定する方法がまともに無い
    # https://github.com/anthropics/claude-code/issues/3321
    home.shellAliases = {
      "cl" = "claude --mcp-config ~/.config/claude/mcp.json";
    };
    xdg.configFile = {
      "claude/mcp.json" = {
        text = builtins.toJSON {
          mcpServers = {
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
              command = "playwright-mcp";
              args = [
                "--browser"
                "chromium"
                "--executable-path"
                chrome-exec-path
                "--user-data-dir"
                "/tmp/pw-mcp"
              ];
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
  };
}
