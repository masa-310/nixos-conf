{
  lib,
  config,
  pkgs,
  ...
}:

with builtins;
with lib;
let
  self = config.modules.service.yubikey;
in
{
  imports = [ ];
  options.modules.service.yubikey = {
    enable = mkEnableOption "yubikey";
    pc = mkOption {
      type = types.enum [ "desktop" "laptop" ];
      description = "Should be either of 'desktop' or 'laptop'";
    };
  };
  config = mkIf self.enable {
    services.udev.packages = [ pkgs.yubikey-personalization ];
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    programs.yubikey-manager = {
      enable = true;
    };
    programs.yubikey-touch-detector = {
      enable = true;
      libnotify = true;
    };
    security.pam.u2f = {
      enable = true;
      control = "required";
      settings = {
        cue = true;
      };
    };
    security.pam.services = {
      greetd = {
        u2fAuth = true;
        unixAuth = self.pc == "laptop";
        rules.auth.u2f.control =  lib.mkForce (if self.pc == "laptop" then "sufficient" else "required" );
      };
      login = {
        u2fAuth = true;
        unixAuth = self.pc == "laptop";
        rules.auth.u2f.control =  lib.mkForce (if self.pc == "laptop" then "sufficient" else "required" );
      };
      sudo = {
        u2fAuth = true;
        unixAuth = false;
        rules.auth.u2f.control =  lib.mkForce (if self.pc == "laptop" then "sufficient" else "required" );
      };
      # security.pam.yubico = {
      #   enable = true;
      #   debug = true;
      #   mode = "challenge-response";
      #   id = [ ];
      # };
    };
  };
}
