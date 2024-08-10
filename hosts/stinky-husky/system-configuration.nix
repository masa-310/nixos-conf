{ lib, config, pkgs, ... }:

{
  imports = [
     ../../templates/system/base.nix
 ];
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.firewall.allowedTCPPorts = [ 3000 3001 ];

  modules = {
    hardware.nvidia.enable = true;
  };
}
