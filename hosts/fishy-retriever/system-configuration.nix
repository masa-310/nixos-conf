{ lib, config, pkgs, extra, ... }:

{
  imports = [
     ../../templates/system/base.nix
    extra.nixos-hardware.nixosModules.lenovo-thinkpad-x1-11th-gen
 ];
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.firewall.allowedTCPPorts = [ 3000 3001 ];

  services.thermald.enable = true;
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
       governor = "powersave";
       turbo = "never";
    };
    charger = {
       governor = "performance";
       turbo = "never";
    };
  };


  modules = {
    service.picom = {
      enable = true;
    };
    service.greetd = {
      enable = true;
    };
    hardware.touchpad = {
      enable = true;
    };
  };
  system.stateVersion = "23.05"; # Did you read the comment?
}
