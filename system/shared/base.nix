{ config, pkgs, ...}:

{
  # networking.wireless.enable = true;
  networking.wireless.iwd.enable = true;
  networking.wireless.iwd.settings.Setting.EnableNetworkConfiguration = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

   #Select internationalisation properties.
   i18n = {
     consoleKeyMap = "us";
     defaultLocale = "en_US.UTF-8";
     inputMethod = {
       enabled = "fcitx5";
       fcitx.engines = with pkgs.fcitx-engines; [ mozc ];
       fcitx5.addons = with pkgs; [
         fcitx5-mozc
       ];
     };
   };
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

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    inconsolata-nerdfont
  ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  networking.resolvconf.dnsExtensionMechanism = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };
  hardware.bluetooth.enable = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  programs.ssh.forwardX11 = true;

  users.users.masashi = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      firefox
      thunderbird
    ];
    initialPassword = "masashi";
  };

  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = true;
  boot.plymouth = {
    enable = true;
  };

  nixpkgs.config = {
    allowUnfree = true;
  };
  nix.settings.extra-experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';
  system.stateVersion = "22.11"; # Did you read the comment?
}
