{ lib, config, pkgs, ... }:

with builtins;
with lib;
let self = config.modules.service._1password;
in {
  imports = [];
  options.modules.service._1password = {
    enable = mkEnableOption "_1password";
  };
  config = mkIf self.enable {
    programs._1password = {
      enable = true;
    };
    programs._1password-gui = {
      enable = true;
    };
  };
}
