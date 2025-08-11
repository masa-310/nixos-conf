{ lib, pkgs, config, ... }:

with builtins;
with lib;
let self = config.modules.tool.geminicommit;
    geminiCommitConf = builtins.fromTOML (builtins.readFile ./geminicommit.toml);
    keyReplacedConf = geminiCommitConf // {
      api = geminiCommitConf.api // {
        key = "$(cat ${config.sops.secrets.geminiApiKey.path})";
      };
    };
in {
  imports = [];
  options.modules.tool.geminicommit = {
    enable = mkEnableOption "geminicommit";
  };
  config =
    mkIf self.enable {
      home.packages = [
        pkgs.geminicommit
      ];
      xdg.configFile = {
        "geminicommit/config.toml".text = keyReplacedConf;
      };
    };
}
