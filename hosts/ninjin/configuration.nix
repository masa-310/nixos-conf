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
    windowManager.xmonad = {
      enable = true;
    };
    terminal.alacritty = {
      enable = true;
    };
  };
}
