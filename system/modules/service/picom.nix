{ lib, config, pkgs, ... }:

with builtins;
with lib;
let self = config.modules.service.picom;
in {
  imports = [];
  options.modules.service.picom = {
    enable = mkEnableOption "picom";
  };
  config = mkIf self.enable {
    services.picom = {
      enable = true;
    };
  };
}
