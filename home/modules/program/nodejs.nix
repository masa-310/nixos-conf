{ lib, config, pkgs, ... }:

with builtins;
with lib;
let self = config.modules.program.nodejs;
    nodejsPkg = pkgs."nodejs_${toString self.version}";
in {
  imports = [];
  options.modules.program.nodejs = {
    enable = mkEnableOption "nodejs";
    version = mkOption {
      type = types.number;
      default = 20;
      description = "Nodejs version. Should be eigther of 14, 16, or 18";
    };
  };
  config = mkIf self.enable {
    home.packages = with pkgs; with nodePackages; [
      nodejsPkg
      typescript-language-server
      #yarn
      # eslint
      eslint_d
      vscode-langservers-extracted
      prettier
      prettierd
      nodePackages."@tailwindcss/language-server"
      volta
      pm2
    ];
    #home.sessionPath = [ "$(${pkgs.yarn}/bin/yarn global bin)" ];
    home.sessionPath = [ "$(${nodejsPkg}/bin/npm config get prefix)/bin" ];
    home.file.".npmrc".text = ''
      prefix=${config.home.homeDirectory}/npm
    '';
  };
}
