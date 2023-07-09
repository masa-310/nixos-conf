{ config, pkgs, home-manager, ... }:

{ imports = [
    ./shared
    ./modules/service/picom.nix
  ];
}
