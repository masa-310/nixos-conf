{ lib, config, pkgs, ... }:

with builtins;
with lib;
let self = config.modules.shell.zsh;
in {
  imports = [];
  options.modules.shell.zsh = {
    enable = mkEnableOption "zsh";
    userName = mkOption {
      type = types.str;
      default = "masashi";
      description = "User name who uses zhs as a default shell.";
    };
    extraDirHashes = mkOption {
      type = types.attrsOf types.str;
      default = {};
      description = "Additional 'dirHashes'";
    };
    extraCommands = mkOption {
      type = types.str;
      default = "";
      description = "Extra commands that will be added to .zshrc";
    };
  };
  config = mkIf self.enable {
    programs.zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      syntaxHighlighting = {
        enable = true;
      };
      dirHashes = {
        pj = "$HOME/project";
        dl = "$HOME/Download";
      } // self.extraDirHashes;
      history.expireDuplicatesFirst = true;
      history.ignoreDups = true;
      history.ignorePatterns = [
        "rm *"
        "mv *"
      ];
      history.ignoreSpace = true;
      historySubstringSearch = {
        enable = true;
        searchDownKey = "^N";
        searchUpKey = "^P";
      };
      initContent = ''
export GEMINI_API_KEY=$(cat ${config.sops.secrets.geminiApiKey.path})
export GITHUB_TOKEN=$(cat ${config.sops.secrets.githubToken.path})
      '';
      plugins = [
        {
          name = "zsh-autosuggestions";
          src = pkgs.fetchFromGitHub {
            owner ="zsh-users";
            repo ="zsh-autosuggestions";
            rev = "v0.7.0";
            sha256 = "1g3pij5qn2j7v7jjac2a63lxd97mcsgw6xq6k5p7835q9fjiid98";
          };
        }
        {
          name = "zsh-syntax-highlighting";
          src = pkgs.fetchFromGitHub {
            owner="zsh-users";
            repo="zsh-syntax-highlighting";
            rev= "0.7.1";
            sha256= "sha256-gOG0NLlaJfotJfs+SUhGgLTNOnGLjoqnUp54V9aFJg8=";
          };
        }
        {
          name = "enhancd";
          file = "init.sh";
          src = pkgs.fetchFromGitHub {
            owner="b4b4r07";
            repo="enhancd";
            rev= "v2.2.4";
            sha256= "1smskx9vkx78yhwspjq2c5r5swh9fc5xxa40ib4753f00wk4dwpp";
          };
        }
      ];
    };
  };
}
