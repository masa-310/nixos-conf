{ lib, config, pkgs, dotfile, ... }:

with builtins;
with lib;
let self = config.modules.program.starship;
in {
  imports = [];
  options.modules.program.starship = {
    enable = mkEnableOption "starship";
    shell = mkOption {
      type = types.str;
      default = "zsh";
      description = "Shell integration. Should be eigther of \"bash\" or \"zsh\"";
    };
  };
  config = mkIf self.enable {
    programs.starship = {
      enable = true;
      enableBashIntegration = self.shell == "bash";
      enableZshIntegration = self.shell == "zsh";
    };
    home.file.".config/starship.toml" = {
      source = dotfile + "/starship.toml";
    };
  };
}
