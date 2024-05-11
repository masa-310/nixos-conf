{ system, nixpkgs, pkgs, home-manager, dotfile, hostname, ... }:

{
  home.file.".Xmodmap" = {
    text = ''
    keycode 102 = Super_L
    '';
  };
  imports = [
    ../../templates/home/base.nix
  ];
  modules = {
    tool = {
      aws = {
        enable = true;
      };
    };
  };
}
