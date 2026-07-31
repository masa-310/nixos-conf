{
  lib,
  config,
  pkgs,
  ...
}:

with builtins;
with lib;
let
  self = config.modules.user.masashi;
in
{
  imports = [ ];
  options.modules.user.masashi = {
    enable = mkEnableOption "masashi";
  };
  config = mkIf self.enable {
    modules = {
      program = {
        nodejs = {
          enable = true;
          version = 22;
        };
        starship = {
          enable = true;
          shell = "zsh";
        };
        rofi = {
          enable = true;
        };
        polybar = {
          enable = true;
        };
        elm = {
          enable = true;
        };
        go = {
          enable = true;
        };
        rust = {
          enable = true;
        };
        c = {
          enable = true;
          # build clang failed for some reason
          # use-clang = true;
        };
        sql = {
          enable = true;
        };
      };
      windowManager.xmonad = {
        enable = true;
      };
      editor.helix = {
        enable = true;
      };
      terminal.wezterm = {
        enable = true;
      };
      shell.zsh = {
        enable = true;
      };
      tool = {
        newsboat = {
          enable = true;
        };
      };
      tool.unixporn = {
        enable = true;
      };
      tool.codebook = {
        enable = true;
      };
      tool.coderabbit = {
        enable = true;
      };
      tool.moor = {
        enable = true;
      };
      tool.playwright = {
        enable = true;
      };
      tool.yazi = {
        enable = true;
      };
      ai = {
        opencode.enable = true;
        crush.enable = true;
        claude-code.enable = true;
        codex.enable = true;
        aider.enable = true;
        aichat.enable = true;
      };
      browser = {
        qutebrowser.enable = true;
      };
      #program.texlive = {
      #  enable = true;
      #  scheme = "japanese";
      #};
      # program.haskell = {
      #   enable = true;
      # };
    };
    fonts.fontconfig.enable = true;
    home = {
      stateVersion = "24.05";
      username = "masashi";
      homeDirectory = "/home/masashi";
      keyboard.layout = "us";
      packages = with pkgs; [
        # android-studio
        docker
        docker-compose
        jq
        # openjdk11
        evince
        google-chrome
        # google-cloud-sdk
        imagemagick
        # texlive.combined.scheme-full
        tree
        slack
        # obsidian
        # nodejs-10_x
        pciutils
        wmname
        # qt6.full
        rbw
        bat
        drawing
        cspell
        nil
        ripgrep
        maim
        slop
        zoom-us
        dconf
        just
        # shotgun
        # hacksaw
        # strongswan
        # xl2tpd
        ngrok
        dnsutils
        gh
        tomato-c
        fd
        eza
        # slack-cli
        obsidian
        p7zip
        devenv
        remmina
        xan
        fd
        scooter
        pdfcpu
        arduino-ide
        typos-lsp
        gemini-cli
        claude-code
        ollama
        github-mcp-server
        ghostscript
        riffdiff
        delta
        google-cloud-sdk
        glow
        dive
        wmctrl
        ffmpeg
        uv
        actionlint
        openai-whisper
        zenity
        eww
        yubikey-manager
        yubioath-flutter
      ];
      pointerCursor = {
        #package = pkgs.redglass;
        #name = "redglass";
        package = pkgs.vanilla-dmz;
        name = "Vanilla-DMZ";
        size = 16;
      };
      shellAliases = {
        g = "git";
        l = "eza";
        la = "eza -a";
        ll = "eza -l";
        lla = "eza -la";
        cat = "bat";
        gch = "git checkout";
        gl = "git log";
        gb = "git branch --sort=-committerdate  --format='%(color:red)%(objectname:short)%(color:reset) %(HEAD) %(align:30)%(color:yellow)%(refname:short)%(color:reset)%(end) %(align:28)%(color:green)%(committerdate:relative)%(color:reset)%(end) %(align:25)%(color:magenta)%(authorname)%(color:reset)%(end) %(color:blue)%(contents:subject)%(color:reset)'";
        gps = "git push";
        gpl = "git pull";
        gf = "git fetch";
        gr = "git reset";
        gd = "git diff";
        gst = "git status";
        ga = "git add";
        # geminicommit
        gmc = "geminicommit";
        gmca = "geminicommit --all";
        gmcp = "geminicommit --push";
        gmcap = "geminicommit --all --push";
        nixconf-home = "pushd $HOME/nixos-conf; just update home; popd";
        nixconf-system = "pushd $HOME/nixos-conf; just update system; popd";
        nixconf-dotfiles = "pushd $HOME/nixos-conf; just update-dotfile home; popd";
        hey = "aichat";
      };
    };

    services.dunst = {
      enable = true;
      settings = {
        global = {
          # 少し大きめに: 横幅とパディング・フォントサイズを拡大
          width = 450;
          height = 200;
          offset = "15x50";
          origin = "top-right";
          padding = 16;
          horizontal_padding = 16;
          frame_width = 3;
          corner_radius = 8;
          font = "monospace 13";
          line_height = 4;
          markup = "full";
        };
        # Catppuccin Mocha ダーク + 水色アクセント
        urgency_low = {
          background = "#1e1e2e";
          foreground = "#cdd6f4";
          frame_color = "#89b4fa";
        };
        urgency_normal = {
          background = "#1e1e2e";
          foreground = "#cdd6f4";
          frame_color = "#89b4fa";
        };
        urgency_critical = {
          background = "#1e1e2e";
          foreground = "#cdd6f4";
          frame_color = "#89b4fa";
        };
      };
    };
    programs = {
      direnv = {
        enable = true;
        enableZshIntegration = true;
        nix-direnv = {
          enable = true;
        };
      };
      command-not-found = {
        enable = true;
      };
      feh = {
        enable = true;
      };
      firefox = {
        enable = true;
        #enableAdobeFlash = true;
      };
      fzf = {
        enable = true;
        enableZshIntegration = true;
      };
      diff-highlight = {
        enable = true;
        enableGitIntegration = true;
      };
      git = {
        enable = true;
        userName = "Masashi SATO";
        userEmail = "gmasa.310@gmail.com";
        package = pkgs.git;
        aliases = {
          ch = "checkout";
          cm = "commit";
          ad = "add";
          df = "diff";
          lg = "log";
          pl = "pull";
          ps = "push";
          st = "status";
          ignore = "update-index --skip-worktree";
          unignore = "update-index --no-skip-worktree";
        };
        ignores = [
          "*.swp"
          ".dccache"
          ".envrc"
          ".direnv"
          ".vim"
        ];
      };
      lazygit = {
        enable = true;
        enableZshIntegration = true;
      };
      htop = {
        enable = true;
      };
      ssh = {
        serverAliveInterval = 60;
      };
    };

    xsession = {
      enable = true;
      initExtra = "xset r rate 200 150";
    };

    sops = {
      defaultSopsFile = ../../../secrets/shared.yaml;
      defaultSymlinkPath = "/run/user/1000/secrets";
      age = {
        keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
        generateKey = true;
      };
      secrets = {
        geminiApiKey.path = "${config.sops.defaultSymlinkPath}/geminiApiKey";
        linearApiKey.path = "${config.sops.defaultSymlinkPath}/linearApiKey";
      };
    };
  };
}
