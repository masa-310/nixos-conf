{
  lib,
  config,
  pkgs,
  extra,
  ...
}:

with builtins;
with lib;
let
  self = config.modules.ai.aider;
in
{
  imports = [ ];
  options.modules.ai.aider = {
    enable = mkEnableOption "aider";
  };
  config = mkIf self.enable {
    home.packages = [
      extra.aider
      pkgs.ffmpeg
      pkgs.portaudio
      pkgs.libsndfile
    ];
    home.file.".aider.conf.yml" = {
      source = ./.aider.conf.yml;
      enable = true;
    };
  };
}
