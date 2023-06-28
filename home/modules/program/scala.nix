{ lib, config, pkgs, dotfile-path, ... }:

with builtins;
with lib;
let self = config.modules.program.scala;
in {
  imports = [];
  options.modules.program.scala = {
    enable = mkEnableOption "scala";
  };
  config = mkIf self.enable {
    home.packages = with pkgs; [
      sbt
      metals
    ];
  };
}
