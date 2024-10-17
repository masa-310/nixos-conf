{ lib, config, pkgs, dotfile, ... }:

with builtins;
with lib;
let self = config.modules.tool.aws;
in {
  imports = [];
  options.modules.tool.aws = {
    enable = mkEnableOption "aws";
  };
  config = mkIf self.enable {
    home.packages = with pkgs; [
      awscli2
      ssm-session-manager-plugin
    ];
  };
}
