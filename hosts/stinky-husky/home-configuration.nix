{ system, nixpkgs, pkgs, home-manager, hostname, ... }:

{
  home.file.".Xmodmap" = {
    text = ''
    !remove mod1 = Alt_L
    !remove mod4 = Super_L
    clear mod1
    clear mod4
    keycode 133 = Alt_L
    keycode 64 = Super_L
    keycode 102 = Super_L
    add mod1 = Alt_L 
    add mod4 = Super_L
    '';
  };
  imports = [
    ../../templates/home/base.nix
  ];
  modules = {
    editor = {
      helix = {
        enable = true;
      };
    };
    program = {
      scala = {
        enable = true;
      };
      terraform = {
        enable = true;
      };
    };
    tool = {
      aws = {
        enable = true;
      };
      xid-gen = {
        enable = true;
      };
    };
  };
  home.stateVersion = "24.05";
  home.packages = [
    pkgs.remmina
  ];
}
