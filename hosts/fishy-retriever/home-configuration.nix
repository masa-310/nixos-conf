{ ... }:

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
  home.stateVersion = "23.05";
}
