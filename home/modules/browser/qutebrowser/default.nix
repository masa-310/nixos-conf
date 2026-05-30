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
    programs.qutebrowser = {
      enable = true;
      keyBindings = {
        normal = {
          ",p" = "spawn --userscript 1pass";
        };
      };
      extraConfig = ''
import catppuccin
catppuccin.setup(c, 'mocha', False)
'';
    };
    xdg.dataFile = {
      "qutebrowser/userscripts/1pass" = {
        enable = true;
        source = ./userscripts/1pass.sh;
      };
    };
    xdg.configFile = {
    #   "qutebrowser/config.py" = {
    #     enable = true;
    #     source = ./config.py;
    #   };
      "qutebrowser/catppuccin.py" = {
        enable = true;
        source = ./catppuccin.py;
      };
    };
  };
}
