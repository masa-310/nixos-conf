{ lib, config, pkgs, dotfile-path, ... }:

with builtins;
with lib;
let self = config.modules.program.nodejs;
in {
  imports = [];
  options.modules.program.nodejs = {
    enable = mkEnableOption "nodejs";
    version = mkOption {
      type = types.number;
      default = 16;
      description = "Nodejs version. Should be eigther of 14, 16, or 18";
    };
  };
  config = mkIf self.enable {
    home.packages = [
      pkgs.${"nodejs-${toString self.version}_x"}
      pkgs.yarn
    ];
  };
}