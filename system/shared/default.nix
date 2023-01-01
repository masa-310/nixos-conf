{ config, pkgs, ... }:

{
  imports =
    [
      ./base.nix
      ./package.nix
      ./service.nix
      ./x.nix
    ];
}
