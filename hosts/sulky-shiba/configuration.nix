{ system, nixpkgs, pkgs, home-manager, dotfile-path, hostname, ... }:

{
  home.file.".Xmodmap" = {
    text = ''
    keycode 102 = Super_L
    '';
  };
  modules = {
    program.elm = {
      enable = true;
    };
    # program.haskell = {
    #   enable = true;
    # };
  };
}
