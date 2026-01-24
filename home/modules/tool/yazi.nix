# https://yazi-rs.github.io/docs/installation
{
  lib,
  config,
  pkgs,
  ...
}:

with builtins;
with lib;
let
  self = config.modules.tool.yazi;
  yazi-plugins = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "68f7d4898c19dcf50beda251f8143992c3e8371f";
    hash = "sha256-6iA/C0dzbLPkEDbdEs8oAnVfG6W+L8/dYyjTuO5euOw=";
  };
in
{
  imports = [ ];
  options.modules.tool.yazi = {
    enable = mkEnableOption "yazi";
  };
  config = mkIf self.enable {
    programs.yazi = {
      enable = true;
      package = pkgs.yazi;
      enableZshIntegration = true;
      shellWrapperName = "y";

      settings = {
        mgr = {
          show_hidden = true;
        };
        preview = {
          max_width = 1000;
          max_height = 1000;
        };
        plugin = {
          prepend_fetchers = [
            {
              id = "git";
              url = "*";
              run = "git";
            }
            {
              id = "git";
              url = "*/";
              run = "git";
            }
          ];
        };
      };
      plugins = {
        git = "${yazi-plugins}/git.yazi";
        full-border = "${yazi-plugins}/full-border.yazi";
        toggle-pane = "${yazi-plugins}/toggle-pane.yazi";
        starship = pkgs.fetchFromGitHub {
          owner = "Rolv-Apneseth";
          repo = "starship.yazi";
          rev = "eca186171c5f2011ce62712f95f699308251c749";
          hash = "sha256-xcz2+zepICZ3ji0Hm0SSUBSaEpabWUrIdG7JmxUl/ts=";
        };
      };

      initLua = ''
        			require("full-border"):setup()
        			require("starship"):setup()
        			require("git"):setup()
        		'';

      keymap = {
        mgr.prepend_keymap = [
          {
            on = "t";
            run = "plugin toggle-pane min-preview";
            desc = "Show or hide the preview pane";
          }
          {
            on = "T";
            run = "plugin toggle-pane max-preview";
            desc = "Maximize or restore the preview pane";
          }
        ];
      };
    };
  };
}
