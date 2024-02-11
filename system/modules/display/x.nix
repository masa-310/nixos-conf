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
      layout = "us";
      xkbOptions = "ctrl:nocaps";

      # Enable touchpad support.
      libinput.enable = true;

      displayManager = {
        startx.enable = true;
      };
    };
    services.autorandr = {
      enable = true;
    };
  };
}

