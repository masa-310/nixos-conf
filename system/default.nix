{ config, pkgs, home-manager, ... }:

{ imports = [
    ./shared
    ./modules/service/picom.nix
    ./modules/service/printer.nix
    ./modules/service/greetd.nix
    ./modules/service/mail.nix
  ];
}
