{ lib, config, pkgs, dotfile, ... }:

with builtins;
with lib;
let self = config.modules.program.sql;
in {
  imports = [];
  options.modules.program.sql = {
    enable = mkEnableOption "sql";
  };
  config = mkIf self.enable {
    home.packages = with pkgs; [
      sqls
    ];
  };
}
