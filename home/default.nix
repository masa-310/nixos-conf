{ config, pkgs, ... }: 


{
  imports = [
    ./modules/editor/nvim.nix
    ./modules/program/nodejs.nix
    ./modules/windowManager/xmonad.nix
    ./modules/terminal/alacritty.nix
  ];
  # Let Home Manager install and manage itself.
  fonts.fontconfig.enable = true;
  home.stateVersion = "22.11";
  home.username = "masashi";
  home.homeDirectory = "/home/masashi";
  home.file.".xinitrc" = {
    text = ''
    exec xmonad
    '';
  };
  home.keyboard.layout = "us";
  home.packages = with pkgs; [
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
    # slop
    # nodejs-10_x
    pciutils
    wmname
    # strongswan
    # xl2tpd
    # xmobar
    # yarn
    # zsh
  ];

  programs = {
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
      };
      ignores = [
        "*.swp"
        ".dccache"
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
    pointerCursor = {
      #package = pkgs.redglass;
      #name = "redglass";
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
      size = 16;
    };
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
 

