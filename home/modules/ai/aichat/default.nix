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
      "aichat/config.yaml" = {
        source = ./config/config.yaml;
        enable = true;
      };
    };
  };
}
