{ system, nixpkgs, pkgs, home-manager, hostname, ... }:

{
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
      geminicommit = {
        enable = true;
      };
    };
  };
  home.stateVersion = "25.11";
  home.packages = [];
}
