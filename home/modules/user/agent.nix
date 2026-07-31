{
  lib,
  config,
  pkgs,
  ...
}:

with builtins;
with lib;
let
  self = config.modules.user.agent;
in
{
  imports = [ ];
  options.modules.user.agent = {
    enable = mkEnableOption "agent";
  };
  config = mkIf self.enable {
    modules = {
      program = {
        nodejs = {
          enable = true;
          version = 22;
        };
        go = {
          enable = true;
        };
      };
      shell.zsh = {
        enable = true;
        userName = "agent";
      };
      tool.playwright = {
        enable = true;
      };
      ai = {
        claude-code.enable = true;
        codex.enable = true;
      };
    };
    fonts.fontconfig.enable = true;
    home = {
      username = "agent";
      homeDirectory = "/home/agent";
      stateVersion = "24.05";
      keyboard.layout = "us";
      packages = with pkgs; [
        docker
        docker-compose
        jq
        imagemagick
        pciutils
        wmname
        ripgrep
        dnsutils
        gh
        fd
        devenv
        fd
        pdfcpu
        ollama
        ghostscript
        uv
        yubikey-manager
        yubioath-flutter
      ];
    };

    programs = {
      git = {
        enable = true;
        userName = "ai-agent";
        userEmail = "agent@example.com";
        package = pkgs.git;
      };
    };

    sops = {
      defaultSopsFile = ../secrets/agent.yaml;
      defaultSymlinkPath = "/run/user/1001/secrets";
      age = {
        keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
        generateKey = true;
      };
      secrets = {
      };
    };
  };
}
