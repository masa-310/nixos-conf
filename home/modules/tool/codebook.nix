{ lib, config, pkgs, extra, ... }:

with builtins;
with lib;
let self = config.modules.tool.codebook;
    codebook = "${extra.codebook}/bin/codebook-lsp";
in {
  imports = [];
  options.modules.tool.codebook = {
    enable = mkEnableOption "codebook";
  };
  config =
    mkIf self.enable {
      # home.packages = [
      #   codebook
      # ];
      xdg.configFile = {
        "codebook/codebook.toml" = {
          source = ./codebook.toml;
          enable = true;
        };
      };
    };
}
