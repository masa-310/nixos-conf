{ lib, config, pkgs, ... }:

{
  imports = [
     ../../templates/system/base.nix
 ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
