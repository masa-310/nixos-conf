{ lib, config, pkgs, ... }:

with builtins;
with lib;
let self = config.modules.display.x;
in {
  imports = [];
  options.modules.display.x = {
    enable = mkEnableOption "x";
  };
  config = mkIf self.enable {
    services.xserver = {
      enable = true;
      xkb = {
        options = "ctrl:nocaps";
        layout = "us";
      };
      displayManager = {
        startx.enable = true;
      };
    };
    services.autorandr = {
      enable = true;
    };
    # Enable touchpad support.
    services.libinput.enable = true;
  };
}

