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
    windowManager.xmonad = {
      enable = true;
    };
    terminal.alacritty = {
      enable = true;
    };
  };
}
