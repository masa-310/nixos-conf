{ lib, config, pkgs, dotfile-path, ... }:

with builtins;
with lib;
let self = config.modules.program.go;
in {
  imports = [];
  options.modules.program.elm = {
    enable = mkEnableOption "go";
  };
  config = mkIf self.enable {
    home.packages = with pkgs; [
      go
      gopls
      air
    ];
  };
}
