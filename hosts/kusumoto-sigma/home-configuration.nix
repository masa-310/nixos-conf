{ system, nixpkgs, pkgs, home-manager, dotfile, hostname, ... }:

{
  home.file.".Xmodmap" = {
    text = ''
    keycode 131 = Super_L
    clear mod4
    add mod4 = Super_L
    '';
  };
  imports = [
    ../../templates/home/base.nix
  ];
  home.stateVersion = "24.05";
  modules = {
    tool = {
      aws = {
        enable = true;
      };
      xid-gen = {
        enable = true;
      };
    };
  };
}
