{ lib, config, pkgs, extra, ... }:

with builtins;
with lib;
let self = config.modules.windowManager.xmonad;
    xmonadCommand = extra.xmonad-config.defaultPackage.${extra.system} + "/bin/xmonad-config";
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

          # import user environment especially for picom
          systemcl --user import-environment XAUTHORITY DISPLAY

          XMONAD_HOST=${extra.hostname} ${xmonadCommand}
        '';
      };
    };
}
