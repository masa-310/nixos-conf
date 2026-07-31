{ lib, config, pkgs, ... }:

{
  imports = [
     ../../templates/system/base.nix
 ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  modules = {
    user = {
      masashi = {
        enable = true;
      };
      agent = {
        enable = true;
      };
    };
  };
  # `../../home` は module レジストリ(imports のみ)。これを読み込まないと
  # modules.* のオプション定義自体が存在しないため agent 側で設定できない。
  home-manager.users.agent = {
    imports = [ ../../home ];
    modules.user.agent.enable = true;
  };

}
