{ lib, config, pkgs, ... }:

with builtins;
with lib;
let self = config.modules.tool._3dprint;
in {
  imports = [];
  options.modules.tool._3dprint = {
    enable = mkEnableOption "_3dprint";
  };
  config = mkIf self.enable {
    home.packages = with pkgs; [
      openscad
      prusa-slicer
    ];
  };
}
