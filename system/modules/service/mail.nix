{ lib, config, pkgs, ... }:

with builtins;
with lib;
let self = config.modules.service.mail;
in {
  imports = [];
  options.modules.service.mail = {
    enable = mkEnableOption "mail";
  };
  config = mkIf self.enable {
    services.postfix = {
      enable = true;
    };
    environment.systemPackages = [
      pkgs.mailutils
    ];
  };
}
