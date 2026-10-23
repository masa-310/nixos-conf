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
    ../../templates/home/base.nix
  ];
  modules = {
    user = {
      masashi.enable = true;
    };
    editor = {
      helix = {
        enable = true;
      };
    };
    program = {
      terraform = {
        enable = true;
      };
    };
    tool = {
      aws = {
        enable = true;
      };
      xid-gen = {
        enable = true;
      };
      geminicommit = {
        enable = true;
      };
    };
  };
  home.stateVersion = "24.05";
}
