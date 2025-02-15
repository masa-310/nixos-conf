{ lib, config, pkgs, extra, ... }:

with builtins;
with lib;
let self = config.modules.editor.helix;
in {
  imports = [];
  options.modules.editor.helix = {
    enable = mkEnableOption "helix";
  };
  config = mkIf self.enable {
    programs.helix = {
      enable = true;
    };
  };
}
