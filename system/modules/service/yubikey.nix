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
      # 有効にした認証方式をデフォルトでandで要求
      # sufficientにするとorになる
      control = "required";
      settings = {
        cue = true;
      };
    };
    security.pam.services = {
      login = {
        u2fAuth = true;
        # laptopなら、ログインはu2f + password
        unixAuth = self.pc == "laptop";
        # u2fAuth=true, unixAuth=falseの状態でrequiredにするとロックアウトされるので、laptopならsufficientで上書きする必要がある
        rules.auth.u2f.control =  lib.mkForce (if self.pc == "laptop" then "sufficient" else "required" );
      };
      sudo = {
        u2fAuth = true;
        # sudoはlaptopで要求しない
        unixAuth = false;
        # u2fAuth=true, unixAuth=falseの状態でrequiredにするとロックアウトされるので、laptopならsufficientで上書きする必要がある
        rules.auth.u2f.control =  lib.mkForce "sufficient";
      };
      sshd.u2f.enable = false;
      # security.pam.yubico = {
      #   enable = true;
      #   debug = true;
      #   mode = "challenge-response";
      #   id = [ ];
      # };
    };
  };
}
