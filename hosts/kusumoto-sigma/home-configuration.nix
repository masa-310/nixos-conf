{...}:

{
  home.file.".Xmodmap" = {
    text = ''
    keycode 131 = Super_L
    clear mod4
    add mod4 = Super_L
    '';
  };
  imports = [
  ];
  home.stateVersion = "24.05";
  modules = {
    user = {
      masashi.enable = true;
    };
  };
}
