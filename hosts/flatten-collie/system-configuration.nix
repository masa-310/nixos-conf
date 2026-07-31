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
  modules = {
    service.yubikey = {
      enable = true;
      pc = "desktop";
    };
  };
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
