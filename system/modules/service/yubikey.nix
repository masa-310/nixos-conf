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
      # NixOS は auth スタックの終端に `auth required pam_deny.so` を必ず置く。
      # required は短絡しないため、pam_u2f が成功しても pam_deny が失敗を返して
      # スタック全体が常に失敗する。鍵だけで通す構成には sufficient が必須。
      control = "sufficient";
      settings = {
        cue = true;
      };
    };
    security.pam.services = {
      # greetd は useDefaultRules = false で auth を `substack login` のみに固定して
      # いるため、ここでの u2f 設定は一切効かない(指定すると modulePath 未定義で
      # eval エラーになる)。greeter の認証は下の login のスタックが決める。
      login = {
        u2f.enable = true;
        # desktop は鍵のみ。laptop はパスワードへのフォールバックを許可。
        unixAuth = self.pc == "laptop";
      };
      sudo = {
        u2f.enable = true;
        unixAuth = false;
      };
      # SSH 越しにサーバ側の鍵をタッチすることはできないので無効化する。
      # 公開鍵認証は PAM の auth スタックを通らないため影響しない。
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
