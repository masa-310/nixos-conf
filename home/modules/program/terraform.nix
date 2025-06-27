{ lib, config, pkgs, ... }:

with builtins;
with lib;
let self = config.modules.program.terraform;
in {
  imports = [];
  options.modules.program.terraform = {
    enable = mkEnableOption "terraform";
  };
  config = mkIf self.enable {
    home.packages = with pkgs; [
      tenv
      terraform-ls
    ];
  };
}
