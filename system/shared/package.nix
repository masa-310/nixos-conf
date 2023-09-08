{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # Packages to respect for Fundamental Human Rights
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
    gnupg
    dmidecode
    sysstat
  ];
}
