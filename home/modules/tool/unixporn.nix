{ lib, config, pkgs, dotfile, ... }:

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
      neofetch
      btop
      pipes
    ];
  };
}
