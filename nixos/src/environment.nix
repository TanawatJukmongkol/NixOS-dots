{
  lib,
  ...
}:
{
  environment.sessionVariables = {
    # Mesa (Intel) drivers take precedence
    LD_LIBRARY_PATH = [
      "/run/opengl-driver/lib"
      "/run/opengl-driver-32/lib"
    ];

    # Use Mesa's GBM and EGL by default (important for Wayland + Intel)
    # GBM_BACKEND = "dri";
    # GBM_BACKENDS_PATH = "/run/opengl-driver/lib/gbm";

    # Let GLX/EGL vendor be chosen dynamically
    # __GLX_VENDOR_LIBRARY_NAME = "mesa";

    # Do not force NVIDIA VAAPI — it is broken
    LIBVA_DRIVER_NAME = "iHD"; # for Intel, or unset if you prefer

    # Vulkan loader should look for both Intel and NVIDIA
    # Let NVIDIA be optional
    # VK_DRIVER_FILES = lib.concatStringsSep ":" [
    #   "/run/opengl-driver/share/vulkan/icd.d/intel_icd.x86_64.json"
    #   "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json"
    # ];

    # Optional: Let Hyprland use wlroots (not NVIDIA GBM Vulkan backend)
    # WLR_BACKEND = "auto";
  };
}
