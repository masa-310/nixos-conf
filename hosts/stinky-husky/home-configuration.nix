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
