{ lib, config, ... }:

with builtins;
with lib;
let self = config.modules.tool.geminicommit;
in {
  imports = [];
  options.modules.tool.geminicommit = {
    enable = mkEnableOption "geminicommit";
  };
  config =
    mkIf self.enable {
      home.packages = [
        geminicommit
      ];
      xdg.configFile = {
        "geminicommit/config.toml" = {
          source = ./geminicommit.toml;
          enable = true;
        };
      };
    };
}
