{ lib, config, pkgs, dotfile-path, ... }:

with builtins;
with lib;
let self = config.modules.program.texlive;
    tex = if self.scheme == "japanese" then
              pkgs.texlive.combine {
                inherit (pkgs.texlive) scheme-medium collection-langjapanese;
              }
          else
              pkgs.texlive.combined.scheme-minimal;
in {
  imports = [];
  options.modules.program.texlive = {
    enable = mkEnableOption "texlive";
    scheme = mkOption {
      type = types.enum [
        "minimal"
        "japanese"
      ];
      default = "minimal";
    };
  };
  config = mkIf self.enable {
    home.packages = [
      tex
    ];
  };
}
