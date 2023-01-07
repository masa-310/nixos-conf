{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # Packages to respect for Fundamental Human Rights
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    unzip
    inetutils
    git
    gptfdisk
    dmenu
    xorg.xev
  ];
}
