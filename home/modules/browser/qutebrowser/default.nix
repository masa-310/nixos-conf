{
  lib,
  config,
  pkgs,
  extra,
  ...
}:

with builtins;
with lib;
let
  self = config.modules.browser.qutebrowser;
in
{
  imports = [ ];
  options.modules.browser.qutebrowser = {
    enable = mkEnableOption "qutebrowser";
  };
  config = mkIf self.enable {
    home.packages = with pkgs; [
      qutebrowser
    ];
    xdg.configFile = {
      "qutebrowser/config.py" = {
        source = "./config.py"
        enable = true;
      };
    };
  };
}
