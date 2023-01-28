{ lib, config, pkgs, dotfile-path, ... }:

with builtins;
with lib;
let self = config.modules.program.nodejs;
in {
  imports = [];
  options.modules.program.elm = {
    enable = mkEnableOption "elm";
  };
  config = mkIf self.enable {
    home.packages = with pkgs.elmPackages; [
      elm
      elm-language-server
      elm-format
      elm-analyse
      create-elm-app
    ];
  };
}
