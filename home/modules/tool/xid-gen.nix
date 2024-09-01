{ lib, config, pkgs, extra, ... }:

with builtins;
with lib;
let self = config.modules.tool.xid-gen;
    xid-gen = extra.xid-gen.packages.${extra.system}.default;
in {
  imports = [];
  options.modules.tool.xid-gen = {
    enable = mkEnableOption "xid-gen";
  };
  config =
    mkIf self.enable {
      home.packages = [
        xid-gen
      ];
    };
}
