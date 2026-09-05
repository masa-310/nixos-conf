{ lib, config, pkgs, ... }:

with builtins;
with lib;
let self = config.modules.user.agent;
in {
  imports = [
    ../service/yubikey.nix
  ];
  options.modules.user.agent = {
    enable = mkEnableOption "agent";
  };
  config = mkIf self.enable {
    users.users.agent = {
      isNormalUser = true;
      uid = 1001;
      shell = pkgs.zsh;
      linger = true;
    };
    programs.zsh ={
      enable = true;
    };
    modules = {
      service.yubikey = {
        enable = true;
        pc = "desktop";
      };
    };
  };
}
