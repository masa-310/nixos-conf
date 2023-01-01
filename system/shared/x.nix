{ config, pkgs, ...}:

{
  # Enable the X11 windowing system.
  # https://wiki.haskell.org/Xmonad/Installing_xmonad
  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "ctrl:nocaps";

    # Enable touchpad support.
    libinput.enable = true;

    displayManager = {
      setupCommands = "autorandr --load";
      sddm = {
        enable = true;
      };
    };
  };
  services.autorandr = {
    enable = true;
  };
}
