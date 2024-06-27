{ lib, config, pkgs, ... }:

with builtins;
with lib;
let self = config.modules.hardware.touchpad;
in {
  imports = [];
  options.modules.hardware.touchpad = {
    enable = mkEnableOption "touchpad";
  };
  config = mkIf self.enable {
    services.xserver.libinput = {
      enable = true;
      touchpad = {
        disableWhileTyping = true;
        naturalScrolling = true;
      };
    };
  };
}

