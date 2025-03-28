{ config, pkgs, extra, ...}:

{
  # packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    ed
    curl
    unzip
    gnumake
    inetutils
    acpi
    pavucontrol
    git
    gptfdisk
    dmenu
    openssl
    xorg.xev
    xorg.xmodmap
    nix-prefetch
    nix-prefetch-git
    gnumeric
    xsel
    xclip
    pinta
    killall
    peek
    xfce.thunar
    imagemagick
    dmidecode
    sysstat
    zip
    lm_sensors
    lshw
    hdparm
    cmake
    pkg-config
    libva-utils
    git-credential-manager
    pstree
  ];

  # ssh
  services = {
    openssh = {
      enable = true;
    };
  };


  # network
  networking = {
    hostName = extra.hostname;
    wireless = {
      iwd = {
        enable = true;
        settings.Setting.EnableNetworkConfiguration = true;
      };
    };
    extraHosts = ''
    127.0.0.1 ads.nicovideo.jp
    '';
    resolvconf.dnsExtensionMechanism = false;
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = false;

   # i18n
   i18n = {
     defaultLocale = "en_US.UTF-8";
     inputMethod = {
       enable = true;
       type = "fcitx5";
       fcitx5.addons = with pkgs; [
         fcitx5-mozc
       ];
     };
   };
   console.keyMap = "us";
   environment.variables ={
      GTK_IM_MODULE = "fcitx";
      QT_IM_MODULE = "fcitx";
      XMODIFIERS = "@im=fcitx";
   };
   console = {
     font = "Lat2-Terminus16";
   };

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

  # font
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    inconsolata-nerdfont
  ];

  # Enable sound.
  # sound.enable = true;
  # sound
  hardware.pulseaudio = {
    enable = false;
    package = pkgs.pulseaudioFull;
  };

  # Enable bluetooth
  hardware.bluetooth.enable = true;


 # boot
  boot.plymouth = {
    enable = true;
  };

  # nixpkgs
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [ "electron-18.1.0" ];
  };

  # nix settings
  nix = {
    optimise = {
      automatic = true;
      dates = [ "03:45" ];
    };
    settings = {
      substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
        "https://cache.iog.io"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      ];
      extra-experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    nixPath = [
      "nixpkgs=${extra.pkg-path}"
      "unstable=${extra.unstable-path}"
      "nixos-config=/etc/nixos/configuration.nix"
      "/nix/var/nix/profiles/per-user/root/channels"
    ];
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
    '';
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  services.pcscd.enable = true;
  programs.gnupg.agent = {
   enable = true;
   enableSSHSupport = true;
};

}
