{ config, pkgs, home-manager, ... }:

{ imports = [
    ./shared
    ./modules/service/picom.nix
    ./modules/service/printer.nix
  ];
}
