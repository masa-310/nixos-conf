{ lib, config, pkgs, extra, ... }:

with builtins;
with lib;
let self = config.modules.tool.codebook;
    codebook = extra.codebook.packages.${extra.system}.default;
in {
  imports = [];
  options.modules.tool.codebook = {
    enable = mkEnableOption "codebook";
  };
  config =
    mkIf self.enable {
      home.packages = [
        codebook
      ];
    };
}
