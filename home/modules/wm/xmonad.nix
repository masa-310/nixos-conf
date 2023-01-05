{ lib, config, pkgs, dotfile-path, hostname, system, ... }:

with builtins;
with lib;
let self = config.modules.wm.xmonad;
in {
  imports = [];
  options.modules.wm.xmonad = {
    enable = mkEnableOption "xmonad";
  };
  config =
    mkIf self.enable {
      home.sessionVariables.XMONAD_HOST = hostname;
      xsession.windowManager = {
        xmonad.enable = true;
        command = pkgs.xmonad-config;
      };
      home.file.".xmonad/xmonad-${system}" = {
        source = pkgs.xmonad-config;
        onChange = ''
          # Attempt to restart xmonad if X is running.
          if [[ -v DISPLAY ]]; then
            ${config.xsession.windowManager.command} --restart
          fi
        '';
      };
    };
}
