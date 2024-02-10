{ lib, config, pkgs, dotfile, ... }:

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
      plugins = with pkgs; [];
      # generated config is not needed so put it in a random place
      # tbh not sure why this option exists
      configPath = ".config/rofi/config-generated.rasi";
    };
    home.file.".config/rofi/config.rasi" = {
      source = dotfile + "/config.rasi";
    };
    home.packages = with pkgs; [
      # https://github.com/NixOS/nixpkgs/issues/218311
      rofi-rbw
      rofi-emoji
      rofi-bluetooth
      rofi-file-browser
      wtype
    ];
  };
}
