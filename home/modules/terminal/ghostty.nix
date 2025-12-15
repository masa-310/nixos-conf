{ lib, config, pkgs, extra, ... }:

with builtins;
with lib;
let self = config.modules.terminal.ghostty;
in {
  imports = [];
  options.modules.terminal.ghostty = {
    enable = mkEnableOption "ghostty";
  };
  config = mkIf self.enable {
    home.packages = [
      pkgs.ghostty
    ];
    home.file."ghostty/config" = {
      source = "${extra.dotfile}/.ghostty.lua";
    };
  };
}
