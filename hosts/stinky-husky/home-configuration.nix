{ system, nixpkgs, pkgs, home-manager, hostname, ... }:

{
  home.file.".Xmodmap" = {
    text = ''
    keycode 102 = Super_L
    '';
  };
  imports = [
    ../../templates/home/base.nix
  ];
}
