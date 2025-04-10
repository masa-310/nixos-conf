{ lib, config, pkgs, ... }:

with builtins;
with lib;
let self = config.modules.program.elm;
in {
  imports = [];
  options.modules.program.elm = {
    enable = mkEnableOption "elm";
  };
  config = mkIf self.enable {
    home.packages = with pkgs.elmPackages; [
      pkgs.watchman
      elm
      # package broken (2025-02-08)
      #elm-test
      elm-language-server
      elm-format
      elm-analyse
      elm-spa
      elm-review
    ];
  };
}
