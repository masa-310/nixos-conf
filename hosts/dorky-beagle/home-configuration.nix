{ system, nixpkgs, pkgs, home-manager, hostname, ... }:

{
  imports = [
    ../../templates/home/base.nix
  ];
  modules = {
    user = {
      masashi.enable = true;
    };
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
      _3dprint = {
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
  home.packages = [];
}
