{ lib, config, pkgs, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.firewall.allowedTCPPorts = [ 3000 3001 ];

  hardware.opengl = {
    enable = true;
  };
  modules = {
    service.picom = {
      enable = true;
    };
  };
}
