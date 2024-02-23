{ system, nixpkgs, pkgs, home-manager, dotfile, hostname, ... }:

{
  imports = [
    ../../templates/home/base.nix
  ];
}
