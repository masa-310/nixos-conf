{ lib, config, pkgs, ... }:

{
  services.xserver.libinput.touchpad = {
    disableWhileTyping = true;
    naturalScrolling = true;
  };
}
