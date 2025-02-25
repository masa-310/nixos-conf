{ lib, config, pkgs, ... }:

with builtins;
with lib;
let self = config.modules.service.printer;
in {
  imports = [];
  options.modules.service.printer = {
    enable = mkEnableOption "printer";
    places = mkOption {
      type = types.enum [ "home" ];
      default = [];
      description = "Places where the printer is used. Should be either of home";
    };
  };
  config = mkIf self.enable {
    services.printing = {
      enable = true;
      # broken
      # drivers = if self.places == "home" then [ pkgs.epson-escpr pkgs.epson-escpr2 ] else [];
    };
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
