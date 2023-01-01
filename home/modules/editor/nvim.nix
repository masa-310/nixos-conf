{ lib, config, pkgs, dotfile-path, ... }:

with builtins;
with lib;
let self = config.modules.editor.neovim;
in {
  imports = [];
  options.modules.editor.neovim = {
    enable = mkEnableOption "neovim";
  };
  config = mkIf self.enable {
    programs.neovim = {
      enable = true;
      vimAlias = true;
      withNodeJs = true;
      withPython3 = true;
      extraConfig = ''
        source ${pkgs.vimPlugins.vim-plug}/plug.vim

        set runtimepath+=${dotfile-path}/nvim
        runtime! init.vim
        runtime! conf/*.vim
        runtime! plugins/*.vim
      '';
    };
  };
}
