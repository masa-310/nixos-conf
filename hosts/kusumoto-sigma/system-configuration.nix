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
  home-manager.users.agent = {
    imports = [ ../../home ];
    modules.user.agent.enable = true;
    systemd.user.timers."ai-review-patroller" = {
      Unit.Description = "AI review patroller timer";
      Timer = {
        OnBootSec = "5m";
        OnUnitActiveSec = "5m";
      };
      Install.WantedBy = [ "timers.target" ];
    };
    systemd.user.services."ai-review-patroller" = {
      Unit.Description = "AI review patroller";
      Service = {
        ExecStart = "/home/agent/ai-review-patroller/patrol.sh";
      };
    };
  };

}
