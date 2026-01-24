{ lib, config, pkgs, ... }:

with builtins;
with lib;
let self = config.modules.tool.moor;
in {
  imports = [];
  options.modules.tool.moor = {
    enable = mkEnableOption "moor";
  };
  config =
    mkIf self.enable {
      home.packages = [
        pkgs.moor
      ];
      home.sessionVariables = {
        PAGER = "moor";
      };
    };
}
