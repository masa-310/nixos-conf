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
    # https://github.com/apognu/tuigreet/issues/68#issuecomment-1586359960
    # this is a life saver.
    # literally no documentation about this anywhere.
    # might be good to write about this...
    # https://www.reddit.com/r/NixOS/comments/u0cdpi/tuigreet_with_xmonad_how/
    systemd.services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal"; # Without this errors will spam on screen
      # Without these bootlogs will spam on screen
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };
  };
}
