{ lib, config, pkgs, extra, ... }:

with builtins;
with lib;
let self = config.modules.program.polybar;
in {
  imports = [];
  options.modules.program.polybar = {
    enable = mkEnableOption "polybar";
  };
  config = mkIf self.enable {
    services.polybar = {
      enable = true;
      script = "";
    };
    home.file.".config/polybar" = {
      source = extra.dotfile + "/polybar";
    };
  };
}
