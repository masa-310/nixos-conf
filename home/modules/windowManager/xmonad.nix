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

          export XMODIFIERS=@im=fcitx
          export GTK_IM_MODULE=fcitx
          export QT_IM_MODULE=fcitx
          export QT5_IM_MODULE=fcitx
          export QT_QPA_PLATFORMTHEME=qt5ct

          XMONAD_HOST=${hostname} ${xmonadCommand}
        '';
      };
    };
}
