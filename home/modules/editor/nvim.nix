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
    # install lua related packages
    home.packages = with pkgs; [
      luajitPackages.jsregexp
      lua-language-server
      efm-langserver
      stylua
    ];
    programs.neovim = {
      enable = true;
      vimAlias = true;
      withNodeJs = true;
      withPython3 = true;
      extraConfig = ''
        set runtimepath+=${dotfile-path}/nvim
        runtime! init.vim
        source ${config.home.homeDirectory}/.nvimrc
      '';
    };
  };
}
