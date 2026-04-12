{ lib, config, pkgs, ... }:

with builtins;
with lib;
let self = config.modules.tool.playwright;
in {
  imports = [];
  options.modules.tool.playwright = {
    enable = mkEnableOption "playwright";
  };
  config =
    mkIf self.enable {
      home.packages = with pkgs; [
        playwright
        playwright-driver.browsers
        playwright-mcp
      ];
      home.sessionVariables = {
        PLAYWRIGHT_BROWSERS_PATH = "${pkgs.playwright-driver.browsers}";
        PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD = "1";
      };
    };
}
