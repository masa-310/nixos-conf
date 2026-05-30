{ lib, config, pkgs, extra, ... }:

with builtins;
with lib;
let self = config.modules.program.rofi;
    rofi-1pass = (pkgs.writeShellScriptBin "rofi-1pass" ''
        ${builtins.readFile ./scripts/1pass.sh}
      '');
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
    xdg.configFile."rofi/config.rasi" = {
      source = extra.dotfile + "/config.rasi";
    };
    xdg.configFile."rofi/scripts/1pass" = {
      source = ./scripts/1pass.sh;
    };
    home.packages = with pkgs; [
      # https://github.com/NixOS/nixpkgs/issues/218311
      rofi-rbw
      rofi-emoji
      rofi-bluetooth
      # rofi-file-browser
      wtype
      rofi-1pass
    ];
  };
}
