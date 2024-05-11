{ ... }:

{
  imports = [
    ../../templates/home/base.nix
  ];
  modules = {
    tool = {
      _3dprint = {
        enable = true;
      };
    };
  };
}
