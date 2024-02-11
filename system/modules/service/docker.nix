# https://nixos.wiki/wiki/Docker

{ lib, config, pkgs, ... }:

with builtins;
with lib;
let self = config.modules.service.docker;
in {
  imports = [];
  options.modules.service.docker = {
    enable = mkEnableOption "docker";
    rootless = mkOption {
      type = types.bool;
      default = false;
    };
  };
  config = mkIf self.enable {
    virtualisation.docker = {
      enable = true;
      enableOnBoot = true;
      rootless = {
        enable = self.rootless;
        setSocketVariable = true;
      };
    };
  };
}

