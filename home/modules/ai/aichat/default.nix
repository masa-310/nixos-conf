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
  self = config.modules.ai.aichat;
  xid-mcp-server = extra.xid-mcp-server.packages.${extra.system}.default;
in
{
  imports = [ ];
  options.modules.ai.aichat = {
    enable = mkEnableOption "aichat";
  };
  config = mkIf self.enable {
    home.packages = [
      pkgs.aichat
    ];
    xdg.configFile = {
      "aichat/config.yaml" = {
        source = ./config.yaml;
        enable = true;
      };
    };
  };
}
