{ lib, config, pkgs, dotfile, ... }:

with builtins;
with lib;
let self = config.modules.tool.newsboat;
in {
  imports = [];
  options.modules.tool.newsboat = {
    enable = mkEnableOption "newsboat";
  };
  config = mkIf self.enable {
    programs.newsboat = {
      enable = true;
      autoReload = true;
      urls = [
        {
          title = "Hacker News";
          url = "https://news.ycombinator.com/rss";
          tags = ["it"];
        }
        {
          title = "Lobsters";
          url = "https://lobste.rs/rss";
          tags = ["it"];
        }
        {
          title = "Reddit NixOS";
          url = "https://www.reddit.com/r/nixos/.rss";
          tags = ["it"];
        }
        {
          title = "Reddit Programming";
          url = "https://www.reddit.com/r/programming/.rss";
          tags = ["it"];
        }
        {
          title = "Reddit Linux";
          url = "https://www.reddit.com/r/linux/.rss";
          tags = ["it"];
        }
        {
          title = "Reddit Open Source";
          url = "https://www.reddit.com/r/opensource/.rss";
          tags = ["it"];
        }
        {
          title = "Reddit Technology";
          url = "https://www.reddit.com/r/technology/.rss";
          tags = ["it"];
        }
        {
          title = "Gigazine";
          url = "https://openrss.org/gigazine.net";
          tags = ["it"];
        }
      ];
    };
  };
}
