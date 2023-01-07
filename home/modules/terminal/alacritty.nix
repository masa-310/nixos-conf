{ lib, config, pkgs, dotfile-path, ... }:

with builtins;
with lib;
let self = config.modules.terminal.alacritty;
in {
  imports = [];
  options.modules.terminal.alacritty = {
    enable = mkEnableOption "alacritty";
  };
  config = mkIf self.enable {
    home.packages = [
      pkgs.alacritty
    ];
    home.file.".config/alacritty.yml" = {
      source = "${dotfile-path}/alacritty.yml";
    };
  };
}
