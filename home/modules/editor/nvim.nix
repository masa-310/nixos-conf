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
    home.packages = [
      pkgs.luajitPackages.jsregexp
    ];
    programs.neovim = {
      enable = true;
      vimAlias = true;
      withNodeJs = true;
      withPython3 = true;
      extraConfig = ''
        source ${pkgs.vimPlugins.vim-plug}/plug.vim

        set runtimepath+=${dotfile-path}/nvim
        runtime! init.vim

        source ${config.home.homeDirectory}/.nvimrc

        let g:coc_config_home = '${dotfile-path}/nvim'
      '';
    };
  };
}
