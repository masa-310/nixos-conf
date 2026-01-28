{ lib, config, pkgs, ... }:

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
      golangci-lint-langserver
      delve
      wire
      mockgen
      gotestsum
      impl
      protolint
      buf
      gci
    ];
    home.sessionPath = [
      "~/go/bin"
    ];
  };
}
