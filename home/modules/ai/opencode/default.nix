{ lib, config, pkgs, ... }:

with builtins;
with lib;
let self = config.modules.ai.opencode;
in {
  imports = [];
  options.modules.ai.opencode = {
    enable = mkEnableOption "opencode";
  };
  config = mkIf self.enable {
    home.packages = [
      pkgs.opencode
    ];
    xdg.configFile = {
      "opencode" = {
        source = ./config;
        enable = true;
      };
    };
  };
}

