{ system, nixpkgs, pkgs, home-manager, dotfile-path, hostname, ... }:

{
  home.file.".Xmodmap" = {
    text = ''
    keycode 102 = Super_L
    '';
  };
  modules = {
    editor.neovim = {
      enable = true;
    };
    program.nodejs = {
      enable = true;
      version = 18;
    };
    program.starship = {
      enable = true;
      shell = "zsh";
    };
    program.rofi = {
      enable = true;
    };
    program.polybar = {
      enable = true;
    };
    windowManager.xmonad = {
      enable = true;
    };
    terminal.alacritty = {
      enable = true;
    };
    shell.zsh = {
      enable = true;
    };
    program.elm = {
      enable = true;
    };
    program.c = {
      enable = true;
      # build clang failed for some reason
      # use-clang = true;
    };
    program.texlive = {
      enable = true;
      scheme = "japanese";
    };
    # program.haskell = {
    #   enable = true;
    # };
  };
}