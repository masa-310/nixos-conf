{ lib, config, pkgs, extra, ... }:

with builtins;
with lib;
let self = config.modules.tool.coderabbit;
    coderabbit = "${extra.coderabbit}";
in {
  imports = [];
  options.modules.tool.coderabbit = {
    enable = mkEnableOption "coderabbit";
  };
  config =
    mkIf self.enable {
      home.packages = [
        coderabbit
      ];
    };
}
