 { config, pkgs, ... }: 


{
  imports = [
    ./modules/editor/nvim.nix
    ./modules/editor/helix.nix
    ./modules/program/nodejs.nix
    ./modules/program/scala.nix
    ./modules/program/elm.nix
    ./modules/program/haskell.nix
    ./modules/program/starship.nix
    ./modules/program/polybar.nix
    ./modules/program/rofi.nix
    ./modules/program/go.nix
    ./modules/program/c.nix
    ./modules/program/rust.nix
    ./modules/program/sql.nix
    ./modules/program/texlive.nix
    ./modules/program/terraform.nix
    ./modules/windowManager/xmonad.nix
    ./modules/terminal/alacritty.nix
    ./modules/terminal/wezterm.nix
    ./modules/shell/zsh.nix
    ./modules/tool/unixporn.nix
    ./modules/tool/codebook.nix
    ./modules/tool/aws.nix
    ./modules/tool/newsboat.nix
    ./modules/tool/_3dprint.nix
    ./modules/tool/xid-gen.nix
    ./modules/tool/broot.nix
    ./modules/tool/geminicommit.nix
  ];
  # Let Home Manager install and manage itself.
  fonts.fontconfig.enable = true;
  home = {
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
      zeal
      # qt6.full
      rbw
      bat
      drawing
      nodePackages.cspell
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
      aichat
      eza
      # slack-cli
      obsidian
      anki
      p7zip
      devenv
      remmina
      xan
      fd
      serpl
      pdfcpu
      arduino-ide
      typos-lsp
      gemini-cli
      github-mcp-server
      ghostscript
      riffdiff
      delta
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
        "shell.nix"
      ];
    };
    htop = {
      enable = true;
    };
    #lsd = {
    #  enable = true;
    #};
    ssh = {
      enable = true;
      controlMaster = "auto";
      controlPersist = "60m";
      serverAliveInterval = 60;
    };
    # taskwarrior = {
    #   enable = true;
    # };
    tmux = {
      enable = true;
#      extraConfig = builtins.readFile("${homedir}/home-manager/.dotfiles/.tmux.conf");
#       plugins = with pkgs; [
#         {
#           plugin = tmuxPlugins.resurrect;
#           extraConfig = ''
#           set -g @resurrect-strategy-nvim 'session'
#           '';
#         }
#         {
#           plugin = tmuxPlugins.continuum;
#           extraConfig = ''
#           set -g @continuum-restore 'on'
#           set -g @continuum-save-interval '60' # minutes
#           '';
#         }
#       ];
    };
#    urxvt = {
#      enable = true;
#      package = pkgs.rxvt_unicode;
#      fonts = ["xft: DejaVu\ Sans\ Mono\ for\ Powerline:antialias=true:size=11:hinting=true"];
#      scroll.bar = {
#        enable = true;
#      };
#    };
#    zsh = {
#      initExtra = builtins.readFile("${homedir}/home-manager/.dotfiles/.zshrc");
#      enable = true;
#      #enableAutosuggestions = true;
#      #enableCompletion = true;
#      #autocd = true;
#      defaultKeymap = "emacs";
#      #dotDir = "./home_manager";
#      history = {
#        ignoreDups = true;
#      };
#    };
  };
  
  #xresources = {
  #  extraConfig = builtins.readFile("${homedir}/home-manager/.dotfiles/.Xresources");
  #};

  xsession = {
    enable = true;
    initExtra = "xset r rate 200 150";
    # profileExtra = builtins.readFile("${homedir}/home-manager/.dotfiles/.xprofile");
    # windowManager = {
    #   xmonad = {
    #     #enable = true;
    #     #enableContribAndExtras = true;
    #     #extraPackages = p: [
    #     #  p.xmonad-contrib
    #     #  p.xmonad-extras
    #     #];
    #     #config = "${homedir}/home-manager/.dotfiles/xmonad.hs";
    #   };
    # };
  };

  sops = {
    defaultSopsFile = ../secrets/shared.yaml;
    defaultSymlinkPath = "/run/user/1000/secrets";
    age = {
      keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
      generateKey = true;
    };
    secrets = {
      geminiApiKey.path = "${config.sops.defaultSymlinkPath}/geminiApiKey";
    };
  };
}
 

