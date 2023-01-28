{ lib, config, pkgs, ... }:

{
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
