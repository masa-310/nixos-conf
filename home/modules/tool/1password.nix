{ lib, config, pkgs, dotfile, ... }:

with builtins;
with lib;
let self = config.modules.tool._1password;
in {
  imports = [];
  options.modules.tool._1password = {
    enable = mkEnableOption "_1password";
  };
  config = mkIf self.enable {
    home.packages = with pkgs; [
      _1password
      _1password-gui-beta
    ];
  };
}
