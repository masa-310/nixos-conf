{ lib, config, pkgs, dotfile-path, ... }:

with builtins;
with lib;
let self = config.modules.program.rofi;
in {
  imports = [];
  options.modules.program.rofi = {
    enable = mkEnableOption "rofi";
  };
  config = mkIf self.enable {
    programs.rofi = {
      enable = true;
    };
    home.file.".config/rofi/config.rasi" = {
      source = dotfile-path + "/config.rasi";
    };
  };
}
