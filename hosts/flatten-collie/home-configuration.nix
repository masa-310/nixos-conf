{ system, nixpkgs, pkgs, home-manager, dotfile, hostname, ... }:

{
  #home.file.".Xmodmap" = {
  #  text = ''
  #  keycode 102 = Super_L
  #  '';
  #};
  imports = [
    ../../templates/home/base.nix
  ];
  home.stateVersion = "24.05";
  modules = {
    editor = {
      helix = {
        enable = true;
      };
      neovim = {
        enable = true;
      };
    };
    program = {
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
      geminicommit = {
        enable = true;
      };
    };
  };
}
