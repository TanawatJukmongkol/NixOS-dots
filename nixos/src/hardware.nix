{
  pkgs,
  lib,
  config,
  ...
} : {
  hardware.cpu.intel.updateMicrocode = true;
  hardware.intel-gpu-tools.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      # intel-vaapi-driver # LIBVA_DRIVER_NAME=i965
      libvdpau-va-gl
      vaapiVdpau
      mesa
      libGL
    ];
  };
  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
    powerManagement = {
      enable = true;
      finegrained = true;
    };
    prime = {
      offload = {
        enable = lib.mkOverride 990 true;
        enableOffloadCmd = lib.mkIf config.hardware.nvidia.prime.offload.enable true;
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
