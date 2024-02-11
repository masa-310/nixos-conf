{ system, nixpkgs, pkgs, home-manager, dotfile, hostname, ... }:

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
    program.polybar = {
      enable = true;
    };
    windowManager.xmonad = {
      enable = true;
    };
    terminal.alacritty = {
      enable = true;
    };
    program.rofi = {
      enable = true;
    };
    shell.zsh = {
      enable = true;
    };
    program.elm = {
      enable = true;
    };
    # program.haskell = {
    #   enable = true;
    # };
  };
}
