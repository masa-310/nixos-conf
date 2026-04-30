# https://nixos.wiki/wiki/Qmk
{
  lib,
  config,
  pkgs,
  ...
}:

with builtins;
with lib;
let
  self = config.modules.service.qmk;
in
{
  imports = [ ];
  options.modules.service.qmk = {
    enable = mkEnableOption "qmk";
  };
  config = mkIf self.enable {
    services.udev.enable = true;
    services.udev.packages = with pkgs; [
      qmk
      qmk-udev-rules
      qmk_hid
      via
      vial
    ];
    hardware.keyboard.qmk.enable = true;
    environment.systemPackages = with pkgs; [
      qmk
      via
      vial
    ];
    services.udev.extraRules = ''
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", ATTRS{idVendor}=="4567", ATTRS{idProduct}=="8888", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
    '';
  };
}
