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
    # powerOnBoot = false;
  };
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";
  };
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    package = pkgs.mesa;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
      intel-media-driver
      intel-vaapi-driver
      libvdpau-va-gl
      mangohud
      egl-wayland
      mesa
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      vulkan-loader
      vulkan-validation-layers
    ];
  };
  hardware.nvidia = {
    open = false;
    nvidiaSettings = true;
    modesetting.enable = true;
    nvidiaPersistenced = true;
    dynamicBoost.enable = true;
    powerManagement = {
      enable = true;
      # finegrained = true;
    };
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
    # package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
    #   version = "580.65.06";
    #   sha256_64bit = "sha256-BLEIZ69YXnZc+/3POe1fS9ESN1vrqwFy6qGHxqpQJP8=";
    #   openSha256 = "sha256-BKe6LQ1ZSrHUOSoV6UCksUE0+TIa0WcCHZv4lagfIgA=";
    #   settingsSha256 = "sha256-9PWmj9qG/Ms8Ol5vLQD3Dlhuw4iaFtVHNC0hSyMCU24=";
    #   persistencedSha256 = "sha256-ETRfj2/kPbKYX1NzE0dGr/ulMuzbICIpceXdCRDkAxA=";
    # };
  };
  hardware.keyboard.qmk.enable = true;
  hardware.opentabletdriver = {
    enable = true;
  };
  hardware.steam-hardware.enable = true;
}
