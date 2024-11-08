 { config, pkgs, ... }: 


{
  imports = [
    ./modules/editor/nvim.nix
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
    ./modules/windowManager/xmonad.nix
    ./modules/terminal/alacritty.nix
    ./modules/terminal/wezterm.nix
    ./modules/shell/zsh.nix
    ./modules/tool/unixporn.nix
    ./modules/tool/aws.nix
    ./modules/tool/newsboat.nix
    ./modules/tool/_3dprint.nix
    ./modules/tool/xid-gen.nix
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
      tenv
      fd
      aichat
      eza
      # slack-cli
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
      l = "ls";
      la = "ls -a";
      ll = "ls -l";
      lla = "ls -la";
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
}
 

