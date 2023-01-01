{ lib, config, pkgs, dotfile-path, hostname, ... }:

with builtins;
with lib;
let self = config.modules.wm.xmonad;
in {
  imports = [];
  options.modules.wm.xmonad = {
    enable = mkEnableOption "xmonad";
  };
  config = mkIf self.enable {
    home.sessionVariables.XMONAD_HOST = hostname;
    xsession.windowManager.xmonad = {
      enable = true;
      config = "${dotfile-path}/.xmonad";
    };
  };
}
