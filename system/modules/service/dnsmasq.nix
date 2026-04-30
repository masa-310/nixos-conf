
{ lib, config, pkgs, ... }:

with builtins;
with lib;
let self = config.modules.service.dnsmasq;
in {
  imports = [];
  options.modules.service.dnsmasq = {
    enable = mkEnableOption "dnsmasq";
    rootless = mkOption {
      type = types.bool;
      default = false;
    };
  };
  config = mkIf self.enable {
    services.dnsmasq = {
      enable = true;
      settings = {
        no-daemon = true;
        bind-interfaces = true;
        address = "/*.app.test/127.0.0.1";
        listen-address = "127.0.0.1";
      };
    };
  };
}

