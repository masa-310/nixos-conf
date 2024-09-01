{ ... }:

{
  imports = [
    ../../templates/home/base.nix
  ];
  modules = {
    program = {
      scala = {
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
    };
  };
}
