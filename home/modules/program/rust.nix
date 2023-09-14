{ lib, config, pkgs, dotfile-path, ... }:

with builtins;
with lib;
let self = config.modules.program.rust;
in {
  imports = [];
  options.modules.program.rust = {
    enable = mkEnableOption "rust";
  };
  config = mkIf self.enable {
    home.packages = with pkgs; [
      rustc
      cargo
      rust-analyzer
      cargo-edit
    ];
  };
}
