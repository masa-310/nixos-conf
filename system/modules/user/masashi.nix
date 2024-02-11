{ lib, config, pkgs, ... }:

with builtins;
with lib;
let self = config.modules.user.masashi;
in {
  imports = [];
  options.modules.user.masashi = {
    enable = mkEnableOption "masashi";
  };
  config = mkIf self.enable {
    users.users.masashi = {
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = [
        "wheel"
        "docker"
        "adbusers"
      ];
      hashedPassword = "$6$refXGb3Yqmu2IBQZ$Lw85vHgBlBNOrhwOJKAxCJ84RQscW/brjyD9qpwsnk893HVnvAzPfOCm4MGngnQ6L2geInnCggG2M9/S1dzLo/";
    };
    programs.zsh ={
      enable = true;
    };
  };
}
