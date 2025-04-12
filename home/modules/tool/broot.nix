{ lib, config, pkgs, dotfile, ... }:

with builtins;
with lib;
let self = config.modules.tool.broot;
in {
  imports = [];
  options.modules.tool.broot = {
    enable = mkEnableOption "broot";
  };
  config = mkIf self.enable {
    programs.broot = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        verbs = [
          {key = "ctrl-n"; execution = ":line_down"; }
          {key = "ctrl-p"; execution = ":line_up"; }
          {key = "ctrl-h"; execution = ":panel_left_no_open"; }          
          {key = "ctrl-l"; execution = ":panel_right"; }
          {key = "ctrl-m"; invocation = "edit"; execution = "$EDITOR +{line} {file}"; apply_to = "text_file"; leave_broot = false; }
          {key = "enter"; invocation = "edit"; execution = "$EDITOR +{line} {file}"; apply_to = "text_file"; leave_broot = false; }
        ];
      };
    };
  };
}
