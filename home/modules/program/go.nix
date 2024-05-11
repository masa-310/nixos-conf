{ lib, config, pkgs, dotfile, ... }:

with builtins;
with lib;
let self = config.modules.program.go;
in {
  imports = [];
  options.modules.program.go = {
    enable = mkEnableOption "go";
  };
  config = mkIf self.enable {
    home.packages = with pkgs; [
      go
      gopls
      air
      go-migrate
      golangci-lint
      gotools
      wire
      mockgen
      gotestsum
    ];
  };
}
