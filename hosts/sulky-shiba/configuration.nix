{ lib, config, pkgs, ... }:

{
  home.file.".Xmodmap" = {
    text = ''
    keycode 102 = Super_L
    '';
  };
  modules = {
    program.elm = {
      enable = true;
    };
  };
}
