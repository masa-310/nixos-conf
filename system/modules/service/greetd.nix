{ lib, config, pkgs, ... }:

with builtins;
with lib;
let self = config.modules.service.greetd;
in {
  imports = [];
  # TODO startx以外
  options.modules.service.greetd = {
    enable = mkEnableOption "greetd";
  };
  config = mkIf self.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd startx";
          user = "greeter";
        };
      };
    };
  };
}
