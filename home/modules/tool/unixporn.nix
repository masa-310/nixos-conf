{ lib, config, pkgs, ... }:

with builtins;
with lib;
let self = config.modules.tool.unixporn;
in {
  imports = [];
  options.modules.tool.unixporn = {
    enable = mkEnableOption "unixporn";
  };
  config = mkIf self.enable {
    home.packages = with pkgs; [
      fastfetch
      btop
      pipes
    ];
  };
}
