{ lib, config, pkgs, dotfile-path, ... }:

with builtins;
with lib;
let self = config.modules.terminal.wezterm;
in {
  imports = [];
  options.modules.terminal.wezterm = {
    enable = mkEnableOption "wezterm";
  };
  config = mkIf self.enable {
    home.packages = [
      pkgs.wezterm
    ];
    home.file.".wezterm.lua" = {
      source = "${dotfile-path}/.wezterm.lua";
    };
  };
}
