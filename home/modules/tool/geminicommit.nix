{ lib, pkgs, config, extra, ... }:

with builtins;
with lib;
let self = config.modules.tool.geminicommit;
    geminicommit-custom = extra.geminicommit-custom.packages.${extra.system}.default;
in {
  imports = [];
  options.modules.tool.geminicommit = {
    enable = mkEnableOption "geminicommit";
  };
  config =
    mkIf self.enable {
      home.packages = [
        geminicommit-custom
      ];
      xdg.configFile = {
        "geminicommit/config.toml" = {
          source = ./geminicommit.toml;
          enable = true;
        };
      };
    };
}
