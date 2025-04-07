{ lib, config, pkgs, ... }:

with builtins;
with lib;
let self = config.modules.program.c;
in {
  imports = [];
  options.modules.program.python = {
    enable = mkEnableOption "python";
  };
  config = mkIf self.enable {
    home.packages = with pkgs; [
      pyright
    ];
  };
}
