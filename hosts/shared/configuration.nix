{ lib, config, pkgs, ... }:

{
  home.file.".Xmodmap" = {
    text = ''
    keycode 102 = Super_L
    '';
  };
  modules = {
    editor.neovim = {
      enable = true;
    };
    program.nodejs = {
      enable = true;
      version = 16;
    };
    program.starship = {
      enable = true;
      shell = "zsh";
    };
    program.polybar = {
      enable = true;
    };
    windowManager.xmonad = {
      enable = true;
    };
    terminal.alacritty = {
      enable = true;
    };
    shell.zsh = {
      enable = true;
    };
  };
}
