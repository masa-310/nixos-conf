{ lib, config, pkgs, ... }:

with builtins;
with lib;
let self = config.modules.program.nodejs;
in {
  imports = [];
  options.modules.program.nodejs = {
    enable = mkEnableOption "nodejs";
    version = mkOption {
      type = types.number;
      default = 18;
      description = "Nodejs version. Should be eigther of 14, 16, or 18";
    };
  };
  config = mkIf self.enable {
    home.packages = with pkgs; with nodePackages; [
      pkgs.${"nodejs-${toString self.version}_x"}
      typescript-language-server
      yarn
      # eslint
      eslint_d
      vscode-langservers-extracted
      prettier
      nodePackages."@tailwindcss/language-server"
      volta
      pm2
    ];
    home.sessionPath = [ "$(${pkgs.yarn}/bin/yarn global bin)" ];
    home.file.".npmrc".text = ''
      prefix=$XDG_DATA_HOME/npm
    '';
  };
}
