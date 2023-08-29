{ system, nixpkgs, pkgs, home-manager, dotfile-path, hostname, ... }:

{
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
    terminal.wezterm = {
      enable = true;
    };
    shell.zsh = {
      enable = true;
    };
    program.elm = {
      enable = true;
    };
    program.go = {
      enable = true;
    };
    program.c = {
      enable = true;
    };
    program.rust = {
      enable = true;
    };
    tool.unixporn = {
      enable = true;
    };
  };
}
