{
  pkgs,
  # lib,
  config,
  ...
} : {
  hardware.enableAllFirmware = true;
  hardware.cpu.intel.updateMicrocode = true;
  hardware.intel-gpu-tools.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      # intel-vaapi-driver # LIBVA_DRIVER_NAME=i965
      intel-media-sdk # Intel QSV
      # vpl-gpu-rt # Intel VPL
      libvdpau-va-gl
      vaapiVdpau
      mesa
      libGL
      mangohud
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
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  hardware.opentabletdriver = {
    enable = true;
  };
}
