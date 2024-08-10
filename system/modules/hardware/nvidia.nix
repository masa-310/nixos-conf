
{ lib, config, pkgs, ... }:

with builtins;
with lib;
let self = config.modules.hardware.nvidia;
in {
  imports = [];
  options.modules.hardware.nvidia = {
    enable = mkEnableOption "nvidia";
  };
  config = mkIf self.enable {
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.opengl.enable = true;
    hardware.nvidia = {
      # Modesetting is needed most of the time
      modesetting.enable = true;

      # Enable power management (do not disable this unless you have a reason to).
      # Likely to cause problems on laptops and with screen tearing if disabled.
      powerManagement.enable = false;
      # powerManagement.finegrained = true;

      # Use the NVidia open source kernel module (which isn't “nouveau”).
      # Support is limited to the Turing and later architectures. Full list of 
      # supported GPUs is at: 
      # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
      # Only available from driver 515.43.04+
      open = false;

      # Enable the Nvidia settings menu,
      # accessible via `nvidia-settings`.
      nvidiaSettings = true;

      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        libvdpau-va-gl
        nvidia-vaapi-driver
        vaapiVdpau
      ];
    };
  };
}

