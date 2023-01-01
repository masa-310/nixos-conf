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
    wm.xmonad = {
      enable = true;
    };
  };
}
