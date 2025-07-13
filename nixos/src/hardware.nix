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
  };
  hardware.nvidia = {
    open = true;
    nvidiaSettings = false;
    modesetting.enable = true;
    nvidiaPersistenced = true;
    dynamicBoost.enable = true;
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
    # package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
    #   version = "575.57.08";
    #   sha256_64bit = "sha256-KqcB2sGAp7IKbleMzNkB3tjUTlfWBYDwj50o3R//xvI=";
    #   openSha256 = "sha256-hEAmFISMuXm8tbsrB+WiUcEFuSGRNZ37aKWvf0WJ2/c=";
    #   settingsSha256 = "sha256-vWnrXlBCb3K5uVkDFmJDVq51wrCoqgPF03lSjZOuU8M=";
    #   persistencedSha256 = "sha256-Len7Va4HYp5r3wMpAhL4VsPu5S0JOshPFywbO7vYnGo=";
    # };
  };
  hardware.keyboard.qmk.enable = true;
  hardware.opentabletdriver = {
    enable = true;
  };
}
