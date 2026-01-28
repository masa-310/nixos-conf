{ lib, config, pkgs, ... }:

with builtins;
with lib;
let self = config.modules.ai.claude-code;
in {
  imports = [];
  options.modules.ai.claude-code = {
    enable = mkEnableOption "claude-code";
  };
  config = mkIf self.enable {
    home.packages = with pkgs; [
      claude-code
      claude-code-router
    ];
    home.file.".claude-code-router/config.json" = {
      source = ./config.json;
      enable = true;
    };
  };
}

