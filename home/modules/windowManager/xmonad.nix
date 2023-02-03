{ lib, config, pkgs, dotfile-path, hostname, system, ... }:

with builtins;
with lib;
let self = config.modules.windowManager.xmonad;
    xmonadCommand = pkgs.xmonad-config.defaultPackage.${system} + "/bin/xmonad-config";
in {
  imports = [];
  options.modules.windowManager.xmonad = {
    enable = mkEnableOption "xmonad";
  };
  config =
    mkIf self.enable {
      xsession.windowManager = {
        xmonad.enable = true;
      };
      home.file.".xinitrc" = {
        executable = true;
        text = ''
          #!/bin/sh

          XMONAD_HOST=${hostname} ${xmonadCommand}
        '';
      };

      #home.file.".xmonad/xmonad-config" = {
      #  # home.file.".xmonad/xmonad-${system}" = {
      #    source = pkgs.xmonad-config.defaultPackage.${system} + "/bin/xmonad-config";
      #    onChange = ''
      #      # Attempt to restart xmonad if X is running.
      #      if [[ -v DISPLAY ]]; then
      #        ${config.xsession.windowManager.command} --restart
      #      fi
      #    '';
      #  };
      #};
    };
}
