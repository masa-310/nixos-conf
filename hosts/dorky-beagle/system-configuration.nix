{
  lib,
  config,
  pkgs,
  ...
}:

{
  imports = [
    ../../templates/system/base.nix
  ];
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.firewall.allowedTCPPorts = [
    3000
    3001
  ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.supportedFilesystems = [ "ntfs" ];
  modules = {
    user = {
      masashi = {
        enable = true;
      };
    };
    service = {
      yubikey = {
        enable = true;
        pc = "laptop";
      };
      printer = {
        enable = true;
        places = "hplip";
      };
    };
  };

  system.stateVersion = "25.11"; # Did you read the comment?
}
