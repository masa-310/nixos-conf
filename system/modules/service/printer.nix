{ lib, config, pkgs, ... }:

with builtins;
with lib;
let self = config.modules.service.printer;
in {
  imports = [];
  options.modules.service.printer = {
    enable = mkEnableOption "printer";
  };
  config = mkIf self.enable {
    services.printing = {
      enable = true;
    };
    services.avahi = {
      enable = true;
      nssmdns = true;
      openFirewall = true;
    };
  };
}
