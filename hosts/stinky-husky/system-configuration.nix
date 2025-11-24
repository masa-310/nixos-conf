{ lib, config, pkgs, ... }:

{
  imports = [
     ../../templates/system/base.nix
 ];
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.firewall.allowedTCPPorts = [ 3000 3001 ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.supportedFilesystems = [ "ntfs" ];

  services.xserver.config = ''
    Section "Device"
      Identifier "Device0"
      Driver "nvidia"
      VendorName  "NVIDIA Corporation"
    EndSection
'';

  modules = {
    hardware.nvidia.enable = true;
    service.printer = {
      enable = true;
      places = "home";
    };
  };

  system.stateVersion = "24.05"; # Did you read the comment?
}
