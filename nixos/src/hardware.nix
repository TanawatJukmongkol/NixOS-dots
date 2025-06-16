{
  pkgs,
  lib,
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
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";
  };
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
      intel-vaapi-driver
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      # intel-vaapi-driver # LIBVA_DRIVER_NAME=i965
      intel-media-sdk # Intel QSV
      vpl-gpu-rt # Intel VPL
      libvdpau-va-gl
      vaapiIntel
      vaapiVdpau
      mesa
      libGL
      libdrm
      mangohud
      egl-wayland
    ];
  };
  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
    nvidiaPersistenced = true;
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
	# package = config.boot.kernelPackages.nvidiaPackages.latest;
	package = (pkgs.unstable.linuxPackagesFor config.boot.kernelPackages.kernel).nvidiaPackages.stable;
  };
  hardware.opentabletdriver = {
    enable = true;
  };
}
