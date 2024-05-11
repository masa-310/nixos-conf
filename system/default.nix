{ config, pkgs, home-manager, pkg-path, unstable-path, ... }:

{ imports = [
    ./base.nix
    ./modules/service/docker.nix
    ./modules/service/greetd.nix
    ./modules/service/mail.nix
    ./modules/service/picom.nix
    ./modules/service/printer.nix
    ./modules/display/x.nix
    ./modules/user/masashi.nix
  ];
}
